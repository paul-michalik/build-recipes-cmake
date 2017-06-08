#include the devkit system file
    
# Boost configuration begin
# We switch off autolinking support in order to have compatible behaviour on all platforms:
# Alternatively we could be using "Boost::disable_autolinking" per target but this guarantees
# a consistent setting for all targets 
add_definitions(-DBOOST_ALL_NO_LIB)

# We require this configuration on all platforms:
set(Boost_USE_STATIC_LIBS        ON)
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)

# We explicitely list all required libraries. This has the advantage of 
# having a single point of failure if one of the libraries is missing.
# I removed the exact version requirement for now in order to simplify the
# cross platform builds during the project start up phase. If there are
# exact specifications we need to become exact again.
find_package(Boost REQUIRED
    unit_test_framework
    filesystem
    # add or remove libraries as required!
)
