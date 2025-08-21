#
#  FindBoostTestHeaders.cmake
#
#  Purpose:
#    CMake module to fetch and configure Boost header-only libraries
#    required for Boost.Test, using FetchContent. Creates an INTERFACE
#    target 'boost_test_headers' with all necessary include paths.
#
#  Usage:
#    include(cmake/FindBoostTestHeaders.cmake)
#    target_link_libraries(<your_target> PRIVATE boost_test_headers)
#
#  Repository:
#    https://github.com/michaeltryby/boost-test-headers
#
#  Copyright (c) 2025 Michael E. Tryby and contributors
#
#  License: MIT
#

cmake_policy(SET CMP0169 OLD)

if(TARGET boost_test_headers)
    return()  # Already created
endif()


include(FetchContent)

set(
  BOOST_VERSION
    "1.88.0"
)

set(
  BOOST_TEST_DEPS
    algorithm assert bind config core detail exception function io iterator
    move mp11 mpl numeric_conversion preprocessor range smart_ptr static_assert
    test throw_exception type_traits utility
)

foreach(lib IN LISTS BOOST_TEST_DEPS)
    FetchContent_Declare(
      Boost${lib}
        URL https://github.com/boostorg/${lib}/archive/refs/tags/boost-${BOOST_VERSION}.tar.gz
    )
    # TODO: To be deprecated (See CMP0169). Need work around
    FetchContent_Populate(
      Boost${lib}
    )
endforeach()

# Create INTERFACE library with all include paths
add_library(
  boost_test_headers
    INTERFACE
)

foreach(lib IN LISTS BOOST_TEST_DEPS)
    target_include_directories(
      boost_test_headers
        INTERFACE
            ${boost${lib}_SOURCE_DIR}/include)
endforeach()


# Mark as found
set(
    boost_test_headers_FOUND TRUE
)
