# Defines for all families of compilers:

# cmake_compile_features were added in version 3.1.
if (NOT CMAKE_VERSION VERSION_LESS 3.1)
    set (CMAKE_CXX_STANDARD 14)
    set (CMAKE_CXX_STANDARD_REQUIRED ON)
    set (CMAKE_CXX_EXTENSIONS OFF)
endif() 
    
# MSVC family of compilers
if (MSVC) 
    # It turns out that CMAKE_CXX_STANDARD & Co. have no effect on MSVC :-(
	if (MSVC_VERSION LESS 1900)
		message(FATAL_ERROR "C++14 is required!")
	endif()
    # /W4: Increase warning level to W4 for all configurations
	# /Gm: Support minimal rebuild for Debug configurations
 	set(CMAKE_CXX_FLAGS_INIT "/DWIN32 /D_WINDOWS /W4 /GR /EHsc")	
    set(CMAKE_CXX_FLAGS_DEBUG_INIT "/Gm /D_DEBUG /MDd /Ob0 /Od /RTC1 /Zi")
	set(CMAKE_C_FLAGS_INIT "/DWIN32 /D_WINDOWS /W4")
	set(CMAKE_C_FLAGS_DEBUG_INIT "/Gm /D_DEBUG /MDd /Zi /Ob0 /Od /RTC1")

	# /MP: Use multi-processor compilation for relase builds
	set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT     "/MP /MD /O1 /Ob1 /DNDEBUG")
	set(CMAKE_CXX_FLAGS_RELEASE_INIT        "/MP /MD /O2 /Ob2 /DNDEBUG")
	# /Ob2: This is actually default when /O2 is used. This way ReleaseWithDebugInfo = Release + Zi
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "/MP /MD /Zi /O2 /Ob2 /DNDEBUG")
	set(CMAKE_C_FLAGS_MINSIZEREL_INIT     "/MP /MD /O1 /Ob1 /DNDEBUG")
	set(CMAKE_C_FLAGS_RELEASE_INIT        "/MP /MD /O2 /Ob2 /DNDEBUG")
	# /Ob2: This is actually default when /O2 is used.
	set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "/MP /MD /Zi /O2 /Ob2 /DNDEBUG")	
endif(MSVC)

# GCC family of compilers
if (CMAKE_COMPILER_IS_GNUCXX)
    # Fall-back when cmake_compile_features are missing
	if (CMAKE_VERSION VERSION_LESS 3.1)
        # Not sure about this, but 4.9 was the lowest version we managed to compile most modules with
		if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.9)
			message(FATAL_ERROR "C++14 is required!")
		endif()

        set(CMAKE_CXX_FLAGS_INIT "-std=c++14")
	endif()
endif()

# This is a hack which fixes a cmake/binutils problem in cmake versions < 3.1
if (UNIX)
    # http://public.kitware.com/Bug/view.php?id=14874
    if (CMAKE_VERSION VERSION_LESS 3.1)
        set(CMAKE_CXX_ARCHIVE_APPEND "<CMAKE_AR> q <TARGET> <LINK_FLAGS> <OBJECTS>")
        set(CMAKE_C_ARCHIVE_APPEND ${CMAKE_CXX_ARCHIVE_APPEND})
    endif()
endif()