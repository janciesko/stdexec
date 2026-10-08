# Minimal, header-only CMake package config for the stdexec headers in this tree.
# Layout:  <prefix>/include/{stdexec,exec,stdexec_version_config.hpp}
#          <prefix>/lib/cmake/stdexec/stdexec-config.cmake   (this file)
# Provides: STDEXEC::stdexec (INTERFACE). No CUDA / nvexec / TBB / Asio / Taskflow.

get_filename_component(_stdexec_prefix "${CMAKE_CURRENT_LIST_DIR}/../../.." ABSOLUTE)

set(STDEXEC_VERSION_MAJOR 0)
set(STDEXEC_VERSION_MINOR 11)
set(STDEXEC_VERSION_PATCH 0)
set(STDEXEC_VERSION "0.11.0")

include(CMakeFindDependencyMacro)
find_dependency(Threads)

if(NOT TARGET STDEXEC::stdexec)
  add_library(STDEXEC::stdexec INTERFACE IMPORTED)
  set_target_properties(STDEXEC::stdexec PROPERTIES
    INTERFACE_COMPILE_FEATURES "cxx_std_20"
    INTERFACE_COMPILE_OPTIONS
      "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:-fcoroutines>;$<$<COMPILE_LANG_AND_ID:CXX,GNU>:-fconcepts-diagnostics-depth=10>"
    INTERFACE_INCLUDE_DIRECTORIES "${_stdexec_prefix}/include"
    INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${_stdexec_prefix}/include"
    INTERFACE_LINK_LIBRARIES "Threads::Threads")
  if(NOT TARGET stdexec::stdexec)
    add_library(stdexec::stdexec INTERFACE IMPORTED)
    set_target_properties(stdexec::stdexec PROPERTIES INTERFACE_LINK_LIBRARIES STDEXEC::stdexec)
  endif()
endif()

set(stdexec_FOUND TRUE)
set(STDEXEC_FOUND TRUE)
unset(_stdexec_prefix)
