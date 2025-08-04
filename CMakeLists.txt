cmake_minimum_required(VERSION 3.16)
project(libraries_frameworks LANGUAGES CXX)

set(CMAKE_CXX_EXTENSIONS OFF)
find_package(CURL REQUIRED)

# Task 1
add_executable(overload overload.cpp)
target_compile_features(overload PRIVATE cxx_std_20)

# Task 3
add_executable(http_demo main_http.cpp)
target_link_libraries(http_demo PRIVATE CURL::libcurl)
target_compile_features(http_demo PRIVATE cxx_std_20)