project "LuaJIT"
   kind "StaticLib"  -- Change to "SharedLib" for a dynamic library.
   language "C"
   targetdir "lib/%{cfg.buildcfg}"
   
   -- Include the core source files.
   files {
      "src/**.c",
      "src/**.h",
      "host/**.c",
      "host/**.h",
      "dynasm/**.lua",
      "dynasm/**.h"
   }
   
   includedirs { "src", "host", "dynasm" }
   defines { "LUAJIT_ENABLE_LUA52COMPAT" }
   buildoptions { "-Wall" }
   
   -- Prebuild command to generate version header info.
   prebuildcommands { "lua host/genversion.lua" }
   
   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"
      buildoptions { "-g" }
   
   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"
      buildoptions { "-O2", "-fomit-frame-pointer" }
   
   filter "configurations:Dist"
      defines { "NDEBUG", "DIST" }
      optimize "Full"
      buildoptions { "-O3", "-fomit-frame-pointer" }
   
   filter {}
