#
#  FindBoostTestHeaders.cmake
#
#  Purpose:
#    CMake module to fetch and configure Boost header-only libraries
#    required for Boost.Test, using FetchContent. Creates an INTERFACE
#    target 'boost_test_headers' with all necessary include paths.
#
#  Usage:
#    find_package(BoostTestHeaders REQUIRED)
#     ...
#    target_link_libraries(<your_target> PRIVATE boost_test_headers)
#
#  Repository:
#    https://github.com/michaeltryby/boost-test-headers
#
#  Copyright (c) 2025-2026 Michael E. Tryby
#
#  License: MIT
#

set(
    CMAKE_SUPPRESS_DEVELOPER_WARNINGS
        ON CACHE BOOL "Suppress developer warnings"
)
set(
    FETCHCONTENT_UPDATES_DISCONNECTED
        ON CACHE BOOL "Disable FetchContent updates during normal builds"
)

# Prevent duplicate inclusion
if(TARGET boost_test_headers)
    set(
        BoostTest_FOUND TRUE
    )
    return()
endif()

message(
    STATUS "Fetching Boost.Test headers"
)


cmake_policy(PUSH)
if(POLICY CMP0169)
    cmake_policy(SET CMP0169 OLD)  # flip to NEW once you migrate off the old behavior
endif()

include(FetchContent)

# Boost version to fetch
set(
    BOOST_VERSION
        "1.88.0" CACHE STRING "Boost version to fetch"
)

set(
  BOOST_TEST_DEPS
    algorithm assert bind config core detail exception function io 
    iterator move mp11 mpl numeric_conversion preprocessor range 
    smart_ptr static_assert test throw_exception type_traits utility
)

# Create INTERFACE library with all include paths
add_library(
  boost_test_headers 
    INTERFACE
)
add_library(
  Boost::test_headers 
    ALIAS 
      boost_test_headers
)

set(
  boost_includes ""
)

foreach(lib IN LISTS BOOST_TEST_DEPS)
    message(VERBOSE "  - Processing boost::${lib}")

    FetchContent_Declare(
      boost_${lib}
        URL https://codeload.github.com/boostorg/${lib}/tar.gz/refs/tags/boost-${BOOST_VERSION}
        DOWNLOAD_EXTRACT_TIMESTAMP TRUE
    )
    
    # We intentionally use FetchContent only as a download mechanism.
    # FetchContent_MakeAvailable() would configure Boost subprojects, which
    # we explicitly do not want. Hence, the call to FetchContent_Populate().
    FetchContent_Populate(
      boost_${lib}
    )

    # Collect all include directories in one list
    list(
      APPEND 
        boost_includes 
          "${boost_${lib}_SOURCE_DIR}/include"
    )
endforeach()


target_include_directories(
  boost_test_headers 
    PUBLIC  
      INTERFACE 
        ${boost_includes}
)


# Set standard find_package variables
set(
  BoostTest_FOUND TRUE
)
set(
  BoostTest_VERSION ${BOOST_VERSION}
)

message(
  STATUS "Boost.Test headers (v${BOOST_VERSION}) configured successfully"
)

# Provide package components for future extensibility
set(
  BoostTest_COMPONENTS headers
)

cmake_policy(POP)
