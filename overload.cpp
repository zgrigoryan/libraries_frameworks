// overload.cpp
#include <string>
struct Foo {
    void f(int) {}
    void f(double) {}
    int  g(const std::string&) const { return 42; }
    static void h() {}
};\

int main() {
    Foo x;
    x.f(1);
    x.f(1.0);
    x.g("hi");
    Foo::h();
}
