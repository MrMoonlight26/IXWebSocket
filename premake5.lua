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
            "/usr/local/opt/openssl@3/include",       -- Intel (x86_64)
            "/opt/homebrew/opt/openssl@3/include"     -- Apple Silicon (arm64)
        }
        libdirs {
            "/usr/local/opt/openssl@3/lib",           -- Intel
            "/opt/homebrew/opt/openssl@3/lib"         -- Apple Silicon
        }
    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"