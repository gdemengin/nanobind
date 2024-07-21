cmake_minimum_required(VERSION 3.29)

project(nf LANGUAGES CXX)

find_package(Python
  REQUIRED COMPONENTS Interpreter Development.Module
  OPTIONAL_COMPONENTS Development.SABIModule)

find_package(nanobind REQUIRED CONFIG)

nanobind_add_module(nf STABLE_ABI NB_STATIC NB_DOMAIN nf src/nf.cpp)
install(TARGETS nf LIBRARY DESTINATION .)
