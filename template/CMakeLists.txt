set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)

set(SUBPROJECT_NAME template)
set(TEST_TARGET "test_${SUBPROJECT_NAME}")

# Main
add_executable(
  hello_main
  source/hello_main.cpp
)
target_include_directories(
  hello_main
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
install(
  TARGETS hello_main
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
)
install(
  DIRECTORY include/
  DESTINATION include
)
# Test
file(GLOB_RECURSE TEST_FILE "test/source/*.cpp")
add_executable(
  ${TEST_TARGET}
  ${TEST_FILE}
)
target_include_directories(
  ${TEST_TARGET}
  PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(
  ${TEST_TARGET}
  PRIVATE
    doctest::doctest
)
# 安裝設定
install(
  DIRECTORY include/
  DESTINATION ${CMAKE_BINARY_DIR}/${SUBPROJECT_NAME}/include
)
