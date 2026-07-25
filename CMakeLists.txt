cmake_minimum_required(VERSION 3.22)
project(RakNet)

# 1. Source File Collection
# Rule B: Replicating all source locations from the legacy Android.mk
file(GLOB RAKNET_SOURCES_CPP "Source/*.cpp")
file(GLOB RAKNET_SOURCES_C   "Source/*.c")
file(GLOB MINIUPNPC_SOURCES  "DependentExtensions/miniupnpc-1.5/*.c")

# Combine all sources into a single list
set(ALL_SOURCES ${RAKNET_SOURCES_CPP} ${RAKNET_SOURCES_C} ${MINIUPNPC_SOURCES})

# 2. Define Static Target
# Pattern: Using 'raknet_static' to match your bridge library list exactly
add_library(raknet_static STATIC ${ALL_SOURCES})

# 3. Include Directories (Exported to Axmol)
# Rule B: Map LOCAL_C_INCLUDES using ${CMAKE_CURRENT_SOURCE_DIR} for portability
target_include_directories(raknet_static PUBLIC 
    ${CMAKE_CURRENT_SOURCE_DIR}/Source
    ${CMAKE_CURRENT_SOURCE_DIR}/DependentExtensions/miniupnpc-1.5
)

# 4. Modern Toolchain Compatibility Adjustments
# Rule C: Patch gaps for older C libraries (like MiniUPNPC)
if(ANDROID)
    # Inject POSIX extensions required for 12-year-old socket code [1, 2]
    # ADD 'ANDROID' to this list to support legacy #if defined(ANDROID) checks
    target_compile_definitions(raknet_static PRIVATE _GNU_SOURCE ANDROID)
    
    # Ensure Android logging is available
    target_link_libraries(raknet_static PUBLIC log)

elseif(WIN32)
    # Link Windows socket library
    target_link_libraries(raknet_static PUBLIC ws2_32)
endif()

