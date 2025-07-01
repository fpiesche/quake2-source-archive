cmake_minimum_required(VERSION 3.10)
set(MOD_NAME "hideandseek")
project(${MOD_NAME} CXX)

file(GLOB MOD_SRC
  "sources/${MOD_NAME}/*.cpp"
  "sources/${MOD_NAME}/*.h"
  "sources/${MOD_NAME}/shared/*.cpp"
  "sources/${MOD_NAME}/shared/*.h"
)

add_library(${MOD_NAME} SHARED ${MOD_SRC})
set_target_properties(${MOD_NAME} PROPERTIES PREFIX "")
set_target_properties(${MOD_NAME} PROPERTIES OUTPUT_NAME "${CMAKE_BINARY_DIR}/${MOD_NAME}/${OS_HANDLE}/game${Q2_BUILD_ARCH}")
target_include_directories(${MOD_NAME} PRIVATE "sources/${MOD_NAME}" "sources/${MOD_NAME}/shared")
