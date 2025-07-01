cmake_minimum_required(VERSION 3.10)
project(q2mods)

# Variables used to control destination filenames and 32bit builds
string(TOLOWER ${CMAKE_SYSTEM_NAME} OS_HANDLE)
option(Q2_BUILD_ARCH "Target architecture to build (default: host architecture)" ${CMAKE_SYSTEM_PROCESSOR})

# Add cmake module path for special-case modules for certain mods
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")


# Remove unnecessary workspace files for 007q2 which break all Windows builds
if (WIN32)
  file(REMOVE_RECURSE sources/007q2)
endif()


# Loop over all subdirectories in `sources` and add each one as a mod target to build
file(GLOB MODS LIST_DIRECTORIES true "sources/*")
foreach(item ${MODS})
	if(IS_DIRECTORY ${item})
    cmake_path(GET item FILENAME mod)

    # If we have a special-case cmake module for the mod, use that
    if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/cmake/mods/${mod}.cmake")
      message(STATUS "Adding mod: cmake/mods/${mod}.cmake")
      include(mods/${mod})

    # Otherwise assume a standard mod setup
    else()
      set(MOD_SRC "")
      file(GLOB MOD_SRC
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.c"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.C"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/*.H"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/src/*.c"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/src/*.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/src/*.C"
        "${CMAKE_CURRENT_SOURCE_DIR}/sources/${mod}/src/*.H"
      )

      # Warn on mods that don't find source files with the above setup
      # so special case modules can be added
      if(NOT MOD_SRC)
        message(WARNING "No source files found for ${mod}")
      else()
        message("-- Adding mod: ${mod}")
        add_library(${mod} SHARED ${MOD_SRC})
        set_target_properties(${mod} PROPERTIES PREFIX "")
        set_target_properties(${mod} PROPERTIES OUTPUT_NAME "bin/${mod}/${OS_HANDLE}/game${Q2_BUILD_ARCH}")

        # Handle 32bit builds
        if (Q2_BUILD_ARCH STREQUAL "x86")
          if(LINUX)
            set(CMAKE_FIND_ROOT_PATH /usr/i686-linux-gnu)
            set_target_properties(${mod} PROPERTIES COMPILE_OPTIONS "-m32" LINK_FLAGS "-m32")
          endif()
        endif()

      endif()
    endif()
  endif()
endforeach()

