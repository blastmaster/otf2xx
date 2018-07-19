option(OTF2_USE_STATIC_LIBS "Link OTF2 statically." ON)
if(OTF2_USE_STATIC_LIBS)
  set(_OTF2_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES ${CMAKE_FIND_LIBRARY_SUFFIXES})
  set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
endif()

IF(OTF2_CONFIG_PATH)
    FIND_PROGRAM(OTF2_CONFIG NAMES otf2-config
        PATHS
        /opt/otf2/bin
        HINTS
        ${OTF2_CONFIG_PATH}
    )
ELSE(OTF2_CONFIG_PATH)
    FIND_PROGRAM(OTF2_CONFIG NAMES otf2-config
        PATHS
        /opt/otf2/bin
    )
ENDIF(OTF2_CONFIG_PATH)

IF(NOT OTF2_CONFIG OR NOT EXISTS ${OTF2_CONFIG})
    MESSAGE(STATUS "no otf2-config found")
    SET(OTF2_VERSION ${OTF2_REQUIRED_VERSION})
ELSE()
    message(STATUS "OTF2 library found. (using ${OTF2_CONFIG})")

    execute_process(COMMAND ${OTF2_CONFIG} "--interface-version" OUTPUT_VARIABLE OTF2_VERSION)
    STRING(REPLACE ":" "." OTF2_VERSION ${OTF2_VERSION})
    STRING(STRIP ${OTF2_VERSION} OTF2_VERSION)

    execute_process(COMMAND ${OTF2_CONFIG} "--cppflags" OUTPUT_VARIABLE OTF2_INCLUDE_DIRS)
    STRING(REPLACE "\n" "" OTF2_INCLUDE_DIRS ${OTF2_INCLUDE_DIRS})
    STRING(REPLACE "-I" ";" OTF2_INCLUDE_DIRS ${OTF2_INCLUDE_DIRS})

    execute_process(COMMAND ${OTF2_CONFIG} "--ldflags" OUTPUT_VARIABLE _LINK_LD_ARGS)
    STRING( REPLACE " " ";" _LINK_LD_ARGS ${_LINK_LD_ARGS} )
    FOREACH( _ARG ${_LINK_LD_ARGS} )
        IF(${_ARG} MATCHES "^-L")
            STRING(REGEX REPLACE "^-L" "" _ARG ${_ARG})
            STRING(STRIP "${_ARG}" _ARG)
            SET(OTF2_LINK_DIRS ${OTF2_LINK_DIRS} ${_ARG})
        ENDIF(${_ARG} MATCHES "^-L")
    ENDFOREACH(_ARG)

    execute_process(COMMAND ${OTF2_CONFIG} "--libs" OUTPUT_VARIABLE _LINK_LD_ARGS)
    STRING( REPLACE " " ";" _LINK_LD_ARGS ${_LINK_LD_ARGS} )
    FOREACH( _ARG ${_LINK_LD_ARGS} )
        IF(${_ARG} MATCHES "^-l")
            STRING(REGEX REPLACE "^-l" "" _ARG "${_ARG}")
            STRING(STRIP "${_ARG}" _ARG)
            # NO_DEFAULT_PATH - We have to "filter" -lm, as g++ links it anyways. And then stuff explodes
            FIND_LIBRARY(_OTF2_LIB_FROM_ARG NAMES ${_ARG}
                HINTS ${OTF2_LINK_DIRS} NO_DEFAULT_PATH
            )
            IF(_OTF2_LIB_FROM_ARG)
                SET(OTF2_LIBRARIES ${OTF2_LIBRARIES} ${_OTF2_LIB_FROM_ARG})
            ENDIF(_OTF2_LIB_FROM_ARG)
            UNSET(_OTF2_LIB_FROM_ARG CACHE)
        ENDIF(${_ARG} MATCHES "^-l")
    ENDFOREACH(_ARG)

    find_program(OTF2_PRINT "otf2-print" PATHS "${OTF2_LINK_DIRS}/.." PATH_SUFFIXES "bin")
ENDIF()

include (FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(OTF2
    FOUND_VAR OTF2_FOUND
    REQUIRED_VARS OTF2_CONFIG OTF2_LIBRARIES OTF2_INCLUDE_DIRS OTF2_PRINT
    VERSION_VAR OTF2_VERSION
)

if(OTF2_FOUND)
    message(STATUS "OTF2 interface version: ${OTF2_VERSION}")

    add_library(otf2::otf2 UNKNOWN IMPORTED GLOBAL)
    set_target_properties(otf2::otf2 PROPERTIES
        IMPORTED_LINK_INTERFACE_LANGUAGES "C"
        IMPORTED_LOCATION "${OTF2_LIBRARIES}"
        INTERFACE_INCLUDE_DIRECTORIES "${OTF2_INCLUDE_DIRS}"
        # Note for MacOS: libm is a symlink to libSystem, so there is no harm to link it anyways, but it isn't required
        INTERFACE_LINK_LIBRARIES "m"
    )

else()
    unset(OTF2_PRINT)
    unset(OTF2_LINK_DIRS)
    unset(OTF2_LIBRARIES)
endif()

if(OTF2_USE_STATIC_LIBS)
  set(CMAKE_FIND_LIBRARY_SUFFIXES ${_OTF2_ORIG_CMAKE_FIND_LIBRARY_SUFFIXES})
endif()
