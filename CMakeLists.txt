



cmake_minimum_required(VERSION 3.23)

list(
    APPEND
        CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake"
)

set(
    FETCHCONTENT_UPDATES_DISCONNECTED
        ON CACHE BOOL
        "Disable FetchContent updates during normal builds"
)


project(MyProject)


enable_testing()
add_subdirectory(test)
