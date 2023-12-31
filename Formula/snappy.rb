class Snappy < Formula
  desc "Compression/decompression library aiming for high speed"
  homepage "https://google.github.io/snappy/"
  url "https://github.com/google/snappy/archive/1.1.9.tar.gz"
  sha256 "75c1fbb3d618dd3a0483bff0e26d0a92b495bbe5059c8b4f1c962b478b6e06e7"
  license "BSD-3-Clause"
  head "https://github.com/google/snappy.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "98a73bdf37639a64a64d17d67ad621d02e36c7aecbc24d5a19febf91dc9dbd5e" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  # Fix issue where Mojave clang fails due to entering a __GNUC__ block
  on_macos do
    depends_on "llvm" => :build if DevelopmentTools.clang_build_version <= 1100
  end

  on_linux do
    # Fix for build failure. Remove with next release.
    patch do
      url "https://github.com/google/snappy/commit/0c716d435abe65250100c2caea0e5126ac4e14bd.patch?full_index=1"
      sha256 "12ff7d1182a35298de3287db32ef8581b8ef600efd6d9509fcc894d3d2056c80"
    end
  end

  fails_with :clang do
    build 1100
    cause "error: invalid output constraint '=@ccz' in asm"
  end

  # Fix issue where `snappy` setting -fno-rtti causes build issues on `folly`
  # `folly` issue ref: https://github.com/facebook/folly/issues/1583
  patch :DATA

  def install
    ENV.remove "HOMEBREW_LIBRARY_PATHS", Formula["llvm"].opt_lib
    ENV.llvm_clang if OS.mac? && (DevelopmentTools.clang_build_version <= 1100)

    # Disable tests/benchmarks used for Snappy development
    args = std_cmake_args + %w[
      -DSNAPPY_BUILD_TESTS=OFF
      -DSNAPPY_BUILD_BENCHMARKS=OFF
    ]

    system "cmake", ".", *args
    system "make", "install"
    system "make", "clean"
    system "cmake", ".", "-DBUILD_SHARED_LIBS=ON", *args
    system "make", "install"
  end

  test do
    # Force use of Clang on Mojave
    ENV.clang if OS.mac?

    (testpath/"test.cpp").write <<~EOS
      #include <assert.h>
      #include <snappy.h>
      #include <string>
      using namespace std;
      using namespace snappy;

      int main()
      {
        string source = "Hello World!";
        string compressed, decompressed;
        Compress(source.data(), source.size(), &compressed);
        Uncompress(compressed.data(), compressed.size(), &decompressed);
        assert(source == decompressed);
        return 0;
      }
    EOS

    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-lsnappy", "-o", "test"
    system "./test"
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 672561e..2f97b73 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -76,10 +76,6 @@ else(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
   # Disable C++ exceptions.
   string(REGEX REPLACE "-fexceptions" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions")
-
-  # Disable RTTI.
-  string(REGEX REPLACE "-frtti" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
-  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
 endif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")

 # BUILD_SHARED_LIBS is a standard CMake variable, but we declare it here to make
