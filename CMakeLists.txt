cmake_minimum_required(VERSION 3.28.3)
project(PROJECT_NAME VERSION 1.0.0 LANGUAGES CXX)

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source build not allowed.")
endif()

option(TEST_VERBOSE "Enable test verbose." OFF)
option(BUILD_new_name "Build new_name." ON)
option(BUILD_template "Build template." ON)

# Release mode
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose build type." FORCE)
endif()

# Cmake set
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# Make output has color
set(CMAKE_COLOR_DIAGNOSTICS ON)

# CPM
include(cmake/CPM.cmake)
cpmaddpackage(
  NAME doctest
  VERSION 2.4.11
  GITHUB_REPOSITORY doctest/doctest
)

# Compile
add_compile_options(-O2 -Wall -Wextra)

# Subprogram
if(TEST_VERBOSE)
  message(STATUS "Test verbose enable.")
  add_compile_definitions(TEST_VERBOSE)
endif()
if(BUILD_template)
  message(STATUS "template enable.")
  add_subdirectory(template)
endif()


