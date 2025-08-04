#include "http_client.hpp"
#include <iostream>

int main() {
    net::CurlGlobal curl_once; // must be created once in the process

    // Simple GET
    net::HttpRequest req;
    auto res = req.set_url("https://httpbin.org/get")
                 .set_timeout_ms(5000)
                 .get();

    std::cout << "GET status: " << res.status << "\n";
    std::cout << "Body size: " << res.body.size() << " bytes\n";

    // POST JSON
    net::HttpRequest postReq;
    auto post = postReq.set_url("https://httpbin.org/post")
                       .set_timeout_ms(5000)
                       .set_body(R"({"x":1})", "application/json")
                       .post();

    std::cout << "POST status: " << post.status << "\n";
    std::cout << post.body << "\n";
}
