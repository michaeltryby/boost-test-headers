

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
  BOOST_LIBRARIES
    algorithm
    assert
    range
    config
    core
    move
    numeric_conversion
    static_assert
    throw_exception
    type_traits
    preprocessor
    mpl
    mp11
    utility
    io
    function
    bind
    smart_ptr
    exception
    detail
    iterator
    test
)

foreach(lib IN LISTS BOOST_LIBRARIES)
    FetchContent_Declare(
      Boost${lib}
        URL https://github.com/boostorg/${lib}/archive/refs/tags/boost-${BOOST_VERSION}.tar.gz
    )
    # TODO: To be deprecated (See CMP0169). Find work around
    FetchContent_Populate(
      Boost${lib}
    )
endforeach()


# Create INTERFACE library with all include paths
add_library(
  boost_test_headers
    INTERFACE
)

foreach(lib IN LISTS BOOST_LIBRARIES)
    target_include_directories(
      boost_test_headers
        INTERFACE
            ${boost${lib}_SOURCE_DIR}/include)
endforeach()

# Mark as found
set(boost_test_headers_FOUND TRUE)
