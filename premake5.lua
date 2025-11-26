project "ixwebsocket"
    kind "StaticLib"
    language "C++"
    cppdialect "C++20"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "ixwebsocket/*.cpp",
        "ixwebsocket/*.h",
        "ixwebsocket/IX*.cpp",
        "ixwebsocket/IX*.h",
    }

    removefiles {
        "ixwebsocket/test/**",
        "ixwebsocket/examples/**",
        "ixwebsocket/docs/**",
        "ixwebsocket/main.cpp",
    }

    includedirs {
        ".",
        "ixwebsocket",
        "ixwebsocket/websocket"
    }

    defines {
        "IXWEBSOCKET_USE_TLS",
        "IXWEBSOCKET_USE_OPEN_SSL",
        "IXWEBSOCKET_USE_STD_MUTEX"
    }

    filter "system:windows"
        systemversion "latest"
        defines { "_CRT_SECURE_NO_WARNINGS" }
        links { "ws2_32", "advapi32", "user32", "crypt32" }
        includedirs {
            "../OpenSSL/3.2.1/include",
        }
        libdirs { 
            "../OpenSSL/3.2.1/lib",
        }
        links {
            "libssl.lib",
        }
    filter "system:linux"
        links { "pthread", "ssl", "crypto" }

    filter "system:macosx"
        links { "pthread", "ssl", "crypto" }
         includedirs {
            "/usr/local/opt/openssl/include", -- for INTEL chip
            "/opt/homebrew/opt/openssl@3/include", -- for APPLE chip
            "/usr/include",
            "/usr/local/include",
            "/usr/local/include/brotli",
            "/opt/homebrew/include"
        }
        libdirs {
            "/usr/local/opt/openssl/lib", -- for INTEL chip
            "/usr/local/lib", -- for INTEL chip
            "/opt/homebrew/opt/openssl@3/lib", -- for APPLE chip
            "/opt/homebrew/", -- for APPLE chip
            "/opt/homebrew/lib"
        }
    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"