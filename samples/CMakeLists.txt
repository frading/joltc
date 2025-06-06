if (NOT JPH_SAMPLES)
    return ()
endif ()

function(add_sample SAMPLE_NAME)
    file(GLOB SOURCE_FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/${SAMPLE_NAME}/*.h"
	    "${CMAKE_CURRENT_SOURCE_DIR}/${SAMPLE_NAME}/*.c"
        "${CMAKE_CURRENT_SOURCE_DIR}/${SAMPLE_NAME}/*.cpp"
    )

    if (ANDROID)
        add_library(${SAMPLE_NAME} SHARED ${SOURCE_FILES})
    else ()
    	add_executable(${SAMPLE_NAME} ${SOURCE_FILES})
    endif ()

    if (DOUBLE_PRECISION)
        target_link_libraries(${SAMPLE_NAME} LINK_PUBLIC joltc_double)
    else()
        target_link_libraries(${SAMPLE_NAME} LINK_PUBLIC joltc)
    endif ()

	if (MSVC)
		target_link_options(${SAMPLE_NAME} PUBLIC "/SUBSYSTEM:CONSOLE")
	endif()

    #if (EMSCRIPTEN)
        set(INTERPROCEDURAL_OPTIMIZATION OFF CACHE BOOL "Always Disable optimisation" FORCE)
        target_compile_options(${SAMPLE_NAME} PUBLIC -pthread)
        target_link_options(${SAMPLE_NAME} PUBLIC -pthread)
        target_compile_options(${SAMPLE_NAME} PUBLIC -sMEMORY64=1)
        target_link_options(${SAMPLE_NAME} PUBLIC -sMEMORY64=1)
        target_link_options(${SAMPLE_NAME} PUBLIC -Wno-limited-postlink-optimizations)
    #else()
    #    SET_INTERPROCEDURAL_OPTIMIZATION()
    #endif()

    set_target_properties(${SAMPLE_NAME} PROPERTIES 
        VS_DEBUGGER_WORKING_DIRECTORY "$<TARGET_FILE_DIR:${SAMPLE_NAME}>"
        FOLDER "samples"
    )
endfunction()

# Add samples
add_sample(01_HelloWorld)
