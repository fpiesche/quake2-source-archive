cmake_minimum_required(VERSION 3.10)
project(q2mods)

option(Q2_BUILD_ARCH "Target architecture to build (default: host architecture)" ${CMAKE_SYSTEM_PROCESSOR})
if (Q2_BUILD_ARCH STREQUAL "x86")
  set(CMAKE_C_FLAGS -m32)
  set(CMAKE_CXX_FLAGS -m32)
  include_directories(/usr/i686-linux-gnu/include/)
endif()

string(TOLOWER ${CMAKE_SYSTEM_NAME} OS_HANDLE)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

file(GLOB MODS LIST_DIRECTORIES true "sources/*")
foreach(item ${MODS})
	if(IS_DIRECTORY ${item})
    cmake_path(GET item FILENAME mod)
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/mods/${mod}.cmake")
      message(STATUS "Adding mod: cmake/mods/${mod}.cmake")
      include(mods/${mod})
    else()
      set(MOD_SRC "")
      file(GLOB MOD_SRC
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.c"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.h"
      )
      if(NOT MOD_SRC)
        message(WARNING "No source files found for ${mod}")
      else()
        message("-- Adding mod: ${mod}")
        add_library(${mod} SHARED ${MOD_SRC})
        set_target_properties(${mod} PROPERTIES PREFIX "")
        set_target_properties(${mod} PROPERTIES OUTPUT_NAME "bin/${mod}/${OS_HANDLE}/game${Q2_BUILD_ARCH}")
      endif()
    endif()
  endif()
endforeach()
