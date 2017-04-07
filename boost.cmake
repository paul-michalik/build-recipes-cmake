#include include the devkit system file    
    
# Boost configuration begin
# We switch off autolinking support in order to have compatible behaviour on all platforms:
add_definitions(-DBOOST_ALL_NO_LIB)

# We require usage of static libraries on all platforms:
set(Boost_USE_STATIC_LIBS ON)

# We explicitely list all required libraries. This has the advantage of 
# having a single point of failure if one of the libraries is missing.
# I removed the exact version requirement for now in order to simplify the
# cross platform builds during the project start up phase. If there are
# exact specifications we need to become exact again.
find_package(Boost REQUIRED
    system 
    filesystem 
    unit_test_framework
    program_options) # add or remove libraries as required!

# Compiler will find boost includes:
include_directories(${Boost_INCLUDE_DIRS}) 

# Linker will find boost libraries:
link_directories(${Boost_LIBRARY_DIRS}) 
# Boost configuration end file contents here
