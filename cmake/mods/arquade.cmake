cmake_minimum_required(VERSION 3.10)
set(MOD_NAME "arquade")
project(${MOD_NAME} CXX)

file(GLOB MOD_SRC
  "sources/${MOD_NAME}/game/*.cpp"
  "sources/${MOD_NAME}/game/*.h"
  "sources/${MOD_NAME}/shared/*.cpp"
  "sources/${MOD_NAME}/shared/*.h"
)

add_library(${MOD_NAME} SHARED ${MOD_SRC})
set_target_properties(${MOD_NAME} PROPERTIES PREFIX "")
set_target_properties(${MOD_NAME} PROPERTIES OUTPUT_NAME "bin/${MOD_NAME}/${OS_HANDLE}/game${Q2_BUILD_ARCH}")
target_include_directories(${MOD_NAME} PRIVATE "sources/${MOD_NAME}/game" "sources/${MOD_NAME}/shared")
