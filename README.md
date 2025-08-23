


# boost test headers

Use FetchContent to manage boost-test dependency

## Why Use BoostTestHeaders?

- No need to download or configure the full Boost library.
- Simplifies CMake dependency management for C++ unit testing.
- Provides a header-only approach for Boost.Test in your project.

## Usage Summary

The easiest way to use this repository is to copy `FindBoostTestHeaders.cmake` into your project, add it to your CMake module path, and call `find_package(BoostTestHeaders)` and link with `boost-test-headers` when building your tests.

### Step-by-Step Usage

1. **Copy Module File:**  
   Download or copy the `FindBoostTestHeaders.cmake` file from this repository into your project's CMake modules directory (e.g., `cmake`).

2. **Set CMake Module Path:**  
   In your project's main `CMakeLists.txt`, ensure your module path is set to include the directory containing `FindBoostTestHeaders.cmake`:

   ```cmake
   list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
   ```

3. **Find Package:**  
   Add the following line to your test build logic to locate Boost.Test headers:

   ```cmake
   find_package(BoostTestHeaders REQUIRED)
   ```

4. **Link Your Test Target:**  
   When declaring your test executable, link it with the `boost_test_headers` target to make the Boost.Test headers available:

   ```cmake
   add_executable(my_test main.cpp)
   target_link_libraries(my_test PRIVATE boost_test_headers)
   ```

