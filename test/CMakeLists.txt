



find_package(
  BoostTestHeaders
    REQUIRED
)

add_executable(
  first_test
    first_test.cpp
)

target_link_libraries(
  first_test
    PRIVATE
        boost_test_headers
)
