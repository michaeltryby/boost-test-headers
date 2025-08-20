cmake_minimum_required(VERSION 4.0.2)
project(MyProject)


list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
find_package(BoostTestHeaders REQUIRED)


add_subdirectory(test)
