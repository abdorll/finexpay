@echo off
"C:\\Users\\user\\AppData\\Local\\Android\\sdk\\cmake\\3.18.1\\bin\\cmake.exe" ^
  "-HC:\\Users\\user\\AppData\\Local\\Pub\\Cache\\hosted\\pub.dev\\rive_common-0.2.2\\android" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=19" ^
  "-DANDROID_PLATFORM=android-19" ^
  "-DANDROID_ABI=arm64-v8a" ^
  "-DCMAKE_ANDROID_ARCH_ABI=arm64-v8a" ^
  "-DANDROID_NDK=C:\\Users\\user\\AppData\\Local\\Android\\sdk\\ndk\\25.1.8937393" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\user\\AppData\\Local\\Android\\sdk\\ndk\\25.1.8937393" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\user\\AppData\\Local\\Android\\sdk\\ndk\\25.1.8937393\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\user\\AppData\\Local\\Android\\sdk\\cmake\\3.18.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=C:\\Administrative\\Projects\\finexpay\\finexpay\\build\\rive_common\\intermediates\\cxx\\RelWithDebInfo\\5e1y2614\\obj\\arm64-v8a" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=C:\\Administrative\\Projects\\finexpay\\finexpay\\build\\rive_common\\intermediates\\cxx\\RelWithDebInfo\\5e1y2614\\obj\\arm64-v8a" ^
  "-DCMAKE_BUILD_TYPE=RelWithDebInfo" ^
  "-BC:\\Users\\user\\AppData\\Local\\Pub\\Cache\\hosted\\pub.dev\\rive_common-0.2.2\\android\\.cxx\\RelWithDebInfo\\5e1y2614\\arm64-v8a" ^
  -GNinja
