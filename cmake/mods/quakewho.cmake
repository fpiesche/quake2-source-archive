cmake_minimum_required(VERSION 3.7)
set(MOD_NAME "quakewho")
project(${MOD_NAME} CXX)


file(GLOB MOD_SRC
  "sources/${MOD_NAME}/*.cpp"
  "sources/${MOD_NAME}/*.h"
)

add_library(${MOD_NAME} SHARED ${MOD_SRC})
set_target_properties(${MOD_NAME} PROPERTIES PREFIX "")
set_target_properties(${MOD_NAME} PROPERTIES OUTPUT_NAME "bin/${MOD_NAME}/game${CMAKE_SYSTEM_PROCESSOR}")
