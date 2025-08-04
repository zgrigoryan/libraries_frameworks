#pragma once
#include <curl/curl.h>

#include <memory>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

namespace net {

// --- RAII for global init/cleanup (call once in main) -----------------------
class CurlGlobal {
public:
    CurlGlobal(unsigned long flags = CURL_GLOBAL_DEFAULT) {
        if (curl_global_init(flags) != 0)
            throw std::runtime_error("curl_global_init failed");
    }
    ~CurlGlobal() { curl_global_cleanup(); }

    CurlGlobal(const CurlGlobal&) = delete;
    CurlGlobal& operator=(const CurlGlobal&) = delete;
    CurlGlobal(CurlGlobal&&) = delete;
    CurlGlobal& operator=(CurlGlobal&&) = delete;
};

// --- Small utilities ---------------------------------------------------------
struct CurlEasyDeleter {
    void operator()(CURL* p) const noexcept { if (p) curl_easy_cleanup(p); }
};
struct CurlSlistDeleter {
    void operator()(curl_slist* p) const noexcept { if (p) curl_slist_free_all(p); }
};

struct HttpResponse {
    long status = 0;
    std::string body;
    std::vector<std::string> headers; // as received, one per line
};

// --- Configurable request object --------------------------------------------
class HttpRequest {
public:
    HttpRequest()
        : easy_(curl_easy_init()),
          errbuf_(errbuf_storage_) {
        if (!easy_) throw std::runtime_error("curl_easy_init failed");

        // Sensible defaults
        set_follow_redirects(true);
        set_timeout_ms(0); // 0 = no timeout
        set_user_agent("net::HttpRequest/1.0");
        curl_easy_setopt(easy_.get(), CURLOPT_ERRORBUFFER, errbuf_);
        curl_easy_setopt(easy_.get(), CURLOPT_WRITEFUNCTION, &HttpRequest::write_body_cb);
        curl_easy_setopt(easy_.get(), CURLOPT_WRITEDATA, this);
        curl_easy_setopt(easy_.get(), CURLOPT_HEADERFUNCTION, &HttpRequest::write_header_cb);
        curl_easy_setopt(easy_.get(), CURLOPT_HEADERDATA, this);
    }

    // move-only
    HttpRequest(const HttpRequest&) = delete;
    HttpRequest& operator=(const HttpRequest&) = delete;
    HttpRequest(HttpRequest&&) = default;
    HttpRequest& operator=(HttpRequest&&) = default;

    // configuration (fluent)
    HttpRequest& set_url(std::string url) {
        url_ = std::move(url);
        curl_easy_setopt(easy_.get(), CURLOPT_URL, url_.c_str());
        return *this;
    }
    HttpRequest& set_timeout_ms(long ms) {
        curl_easy_setopt(easy_.get(), CURLOPT_TIMEOUT_MS, ms);
        return *this;
    }
    HttpRequest& set_follow_redirects(bool yes) {
        curl_easy_setopt(easy_.get(), CURLOPT_FOLLOWLOCATION, yes ? 1L : 0L);
        return *this;
    }
    HttpRequest& set_user_agent(std::string_view ua) {
        user_agent_ = std::string(ua);
        curl_easy_setopt(easy_.get(), CURLOPT_USERAGENT, user_agent_.c_str());
        return *this;
    }
    HttpRequest& add_header(std::string_view h) {
        // keep ownership via unique_ptr
        headers_.reset(curl_slist_append(headers_.release(), std::string(h).c_str()));
        return *this;
    }
    HttpRequest& set_body(std::string body, std::string_view content_type = {}) {
        body_ = std::move(body);
        if (!content_type.empty()) add_header(std::string("Content-Type: ") + std::string(content_type));
        return *this;
    }

    // HTTP verbs
    HttpResponse get() {
        reset_buffers();
        curl_easy_setopt(easy_.get(), CURLOPT_HTTPGET, 1L);
        return perform();
    }
    HttpResponse del() {
        reset_buffers();
        curl_easy_setopt(easy_.get(), CURLOPT_CUSTOMREQUEST, "DELETE");
        return perform();
    }
    HttpResponse post() {
        reset_buffers();
        curl_easy_setopt(easy_.get(), CURLOPT_POST, 1L);
        curl_easy_setopt(easy_.get(), CURLOPT_POSTFIELDS, body_.c_str());
        curl_easy_setopt(easy_.get(), CURLOPT_POSTFIELDSIZE, static_cast<long>(body_.size()));
        return perform();
    }
    HttpResponse put() {
        reset_buffers();
        curl_easy_setopt(easy_.get(), CURLOPT_CUSTOMREQUEST, "PUT");
        curl_easy_setopt(easy_.get(), CURLOPT_POSTFIELDS, body_.c_str());
        curl_easy_setopt(easy_.get(), CURLOPT_POSTFIELDSIZE, static_cast<long>(body_.size()));
        return perform();
    }

private:
    static size_t write_body_cb(char* ptr, size_t sz, size_t nmemb, void* userdata) {
        auto* self = static_cast<HttpRequest*>(userdata);
        self->response_.body.append(ptr, sz * nmemb);
        return sz * nmemb;
    }
    static size_t write_header_cb(char* ptr, size_t sz, size_t nmemb, void* userdata) {
        auto* self = static_cast<HttpRequest*>(userdata);
        self->response_.headers.emplace_back(ptr, sz * nmemb); // includes trailing CRLF
        return sz * nmemb;
    }

    HttpResponse perform() {
        if (headers_) curl_easy_setopt(easy_.get(), CURLOPT_HTTPHEADER, headers_.get());

        const auto rc = curl_easy_perform(easy_.get());
        if (rc != CURLE_OK) {
            // errbuf_ may contain more detail than curl_easy_strerror
            std::string msg = errbuf_[0] ? errbuf_ : curl_easy_strerror(rc);
            throw std::runtime_error("curl_easy_perform: " + msg);
        }
        curl_easy_getinfo(easy_.get(), CURLINFO_RESPONSE_CODE, &response_.status);
        return response_;
    }

    void reset_buffers() {
        response_ = HttpResponse{}; // clear body/headers/status
        errbuf_[0] = '\0';
    }

    std::unique_ptr<CURL, CurlEasyDeleter> easy_;
    std::unique_ptr<curl_slist, CurlSlistDeleter> headers_;
    std::string url_, user_agent_, body_;
    HttpResponse response_;

    char errbuf_storage_[CURL_ERROR_SIZE]{};
    char* errbuf_ = nullptr;
};

} // namespace net
