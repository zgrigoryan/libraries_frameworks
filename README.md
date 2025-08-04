# Libraries, Frameworks and APIs

## Exploring C++ Name Mangling & ABI Differences

This experiment shows how **GCC/Clang (Itanium ABI)** and **MSVC (Microsoft ABI)** encode the same C++ function names differently.

### Reproduce locally (macOS)

```bash
# Apple Clang (libc++)
clang++ -std=c++20 -O0 -c overload.cpp -o clang.o
llvm-nm clang.o                 # mangled
llvm-nm --demangle clang.o      # demangled (or: nm -C clang.o)

# Optional: Homebrew GCC (libstdc++)
# brew install gcc
g++-14 -std=c++20 -O0 -c overload.cpp -o gcc.o   # adjust version if needed
nm gcc.o
nm -C gcc.o
```

> Tip: On macOS, prefer `llvm-nm` or `nm -C` for demangling. `c++filt` also works.

---

### Reproduce in Compiler Explorer (Godbolt)

* Add three compilers: **GCC x86-64**, **Clang x86-64**, **MSVC/clang-cl x64**.
* Flags:

  * GCC/Clang: `-std=c++20 -O0 -fno-inline -fno-omit-frame-pointer`
  * MSVC: `/std:c++20 /Od`
* Turn **off “Demangle identifiers”** in the assembly view to see raw mangled names.

---

### Observed mangled names

| Function                                  | GCC / Clang (Itanium ABI)                                                                                                                                                                     | MSVC (Microsoft ABI)                                                               |
| ----------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| `Foo::f(int)`                             | `_ZN3Foo1fEi`                                                                                                                                                                                 | `?f@Foo@@QEAAXH@Z`                                                                 |
| `Foo::f(double)`                          | `_ZN3Foo1fEd`                                                                                                                                                                                 | `?f@Foo@@QEAAXN@Z`                                                                 |
| `Foo::g(std::string const&) const -> int` | **GCC (libstdc++)**: `_ZNK3Foo1gERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE`  **Clang (libc++)**: `_ZNK3Foo1gERKNSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE` | `?g@Foo@@QEBAHAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z` |
| `Foo::h()` (static)                       | `_ZN3Foo1hEv`                                                                                                                                                                                 | `?h@Foo@@SAXXZ`                                                                    |

**Notes**

* **Itanium ABI (GCC/Clang)** encodes scopes and types compactly:

  * `_Z` prefix signals a mangled symbol.
  * `N ... E` means *nested name*; `3Foo` (length+“Foo”), `1f` (“f”).
  * Parameter codes: `i` = `int`, `d` = `double`.
  * `K` before the class name indicates a `const`-qualified member function (seen on `g`).
  * `std::string` differs by standard library: `__cxx11` (libstdc++) vs `__1` (libc++).
* **Microsoft ABI (MSVC/clang-cl)** decorates as `?name@Class@@...`:

  * `QEAAXH@Z` ≈ this-pointer + `void` return + `int` parameter.
  * `N` encodes `double`.
  * `SAXXZ` indicates `static void()`.

---

### Sample symbol tables from this repo’s runs

**Apple Clang (libc++) object (`clang.o`):**

```
__ZN3Foo1fEi
__ZN3Foo1fEd
__ZN3Foo1hEv
__ZNK3Foo1gERKNSt3__112basic_stringIcNS0_11char_traitsIcEENS0_9allocatorIcEEEE
```

**GCC 13.4 on Godbolt (libstdc++):**

```
_ZN3Foo1fEi
_ZN3Foo1fEd
_ZNK3Foo1gERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE
_ZN3Foo1hEv
```

**MSVC x64 on Godbolt:**

```
?f@Foo@@QEAAXH@Z
?f@Foo@@QEAAXN@Z
?g@Foo@@QEBAHAEBV?$basic_string@DU?$char_traits@D@std@@V?$allocator@D@2@@std@@@Z
?h@Foo@@SAXXZ
```

---

### Takeaways

* **Same C++** produces **different mangled names** depending on platform ABI and standard library.
* GCC and Clang generally align on **Itanium C++ ABI**; differences you see in `std::string` come from **libstdc++ vs libc++** inline namespaces.
* MSVC uses the **Microsoft ABI**, with visibly different decoration for class scope, calling convention, qualifiers, and parameter types.

---

### Comparison - Mangled Names

![Mangled names: GCC/Clang (Itanium) vs MSVC (Microsoft ABI)](./static_h.png)



## Designing an API wrapper

This section adds a tiny, safe C++ layer on top of the C libcurl API.

### Files

* `http_client.hpp` — RAII wrapper (`CurlGlobal`, `HttpRequest`, `HttpResponse`)
* `main_http.cpp` — demo using the wrapper

### Build & run

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --parallel

./build/http_demo
```

### What you should see

Example run (truncated):

```
GET status: 200
Body size: 264 bytes
POST status: 200
{
  "args": {},
  "data": "{\"x\":1}",
  "headers": {
    "Content-Type": "application/json",
    "User-Agent": "net::HttpRequest/1.0",
    ...
  },
  "json": { "x": 1 },
  "url": "https://httpbin.org/post"
}
```

### Wrapper API (high level)

```cpp
net::CurlGlobal curl_once;  // global init/cleanup (RAII)

auto get = net::HttpRequest{}
            .set_url("https://httpbin.org/get")
            .set_timeout_ms(5000)
            .get();                 // HttpResponse { status, body, headers }

auto post = net::HttpRequest{}
             .set_url("https://httpbin.org/post")
             .set_body(R"({"x":1})", "application/json")
             .post();
```

### Why this follows RAII/best practices

* **Ownership & cleanup**: `CURL*` and `curl_slist*` are held by `std::unique_ptr` with custom deleters → no leaks, no manual `cleanup()` calls.
* **Global lifetime**: `CurlGlobal` pairs `curl_global_init/cleanup` automatically and exactly once.
* **Exception safety**: failures throw `std::runtime_error` with a populated libcurl error buffer; destructors still run.
* **Move-only**: copying a handle is disabled; moving is allowed to transfer ownership.
* **Reasonable defaults**: follow redirects, user agent set, body/header callbacks installed internally.
* **Fluent configuration**: `set_url()`, `set_timeout_ms()`, `add_header()`, `set_body()` → reads like intent, not plumbing.

### Before vs After (API design)

**Raw C (before)**

* Multiple `curl_easy_setopt` calls per request.
* You must wire callbacks and manage `curl_slist` yourself.
* Manual cleanup on every return path (`curl_slist_free_all`, `curl_easy_cleanup`).
* Error handling via `CURLcode` + global error buffer.

**RAII wrapper (after)**

* One object per request (`HttpRequest`) + one global guard (`CurlGlobal`).
* Clear, discoverable methods (IDE completion) instead of stringly-typed options.
* Automatic cleanup on scope exit, even on exceptions.
* Results returned as a typed `HttpResponse` (`status`, `body`, `headers`).

### Design notes / extensibility

* **Threading**: Create `CurlGlobal` before spawning threads. Use each `HttpRequest` from a single thread at a time.
* **Error model**: Currently exceptions; could be swapped for `std::expected` if you prefer non-throwing flows.
* **Easy to extend**: add helpers like `bearer_token()`, `accept_json()`, `add_query_param()`, TLS/Proxy options, retries/backoff, streaming to a file, etc.
