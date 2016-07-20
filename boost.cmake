cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# Boost configuration begin
# We switch off autolinking support in order to be compatible on all platforms:
add_definitions(-DBOOST_ALL_NO_LIB)

# We require usage of static libraries on all platforms:
set(Boost_USE_STATIC_LIBS ON)

# We require usage of dynamic libraries on all platforms:
# add_definitions(-DBOOST_ALL_NODYN_LINK)

# We explicitely list all required libraries. This has the advantage of having a single point of failure if one of the libraries is missing:
find_package(Boost 1.61 EXACT REQUIRED
    system 
    filesystem 
    unit_test_framework) # add other libraries as required!

# Compiler will find boost includes:
include_directories(${Boost_INCLUDE_DIRS}) 

# Linker will find boost libraries:
link_directories(${Boost_LIBRARY_DIRS}) 
# Boost configuration end file contents here