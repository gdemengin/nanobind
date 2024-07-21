cmake_minimum_required(VERSION 3.29)

project(mre LANGUAGES CXX)

find_package(Python
  REQUIRED COMPONENTS Interpreter Development.Module
  OPTIONAL_COMPONENTS Development.SABIModule)

find_package(nanobind REQUIRED CONFIG)

add_compile_options(-fsanitize=address -fno-sanitize=vptr)
add_link_options(LINKER:-fsanitize=address)

nanobind_add_module(mre STABLE_ABI NB_STATIC NB_DOMAIN mre src/mre.cpp)
#target_compile_options(mre BEFORE PUBLIC -fsanitize=address -fno-sanitize=vptr)
#target_link_options(mre BEFORE PUBLIC LINKER:-fsanitize=address)
install(TARGETS mre LIBRARY DESTINATION .)
