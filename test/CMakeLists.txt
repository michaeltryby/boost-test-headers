



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

add_test(
    NAME
        first_test
    COMMAND
        first_test
)
