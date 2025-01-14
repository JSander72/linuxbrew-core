class HowardHinnantDate < Formula
  desc "C++ library for date and time operations based on <chrono>"
  homepage "https://github.com/HowardHinnant/date"
  url "https://github.com/HowardHinnant/date/archive/v3.0.1.tar.gz"
  sha256 "7a390f200f0ccd207e8cff6757e04817c1a0aec3e327b006b7eb451c57ee3538"
  license "MIT"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "deff47e2027f805ef5cd430d0700470cf8bada0cde442e8674ae6a832e3b9888"
    sha256 cellar: :any,                 big_sur:       "b8fc90e684f2d3b711fcb405c082f8ad637eac8f6c5816b746284c911950eb5a"
    sha256 cellar: :any,                 catalina:      "bebf754666baa69673a77fb5eeb3c0ebe9931b7aa2d3991a3f6fa235a439d11b"
    sha256 cellar: :any,                 mojave:        "d140b4b590c5ef8c25e80abaa8466dbcb6f10a95ca0dec551de7fb0e213171b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "477b4054dcafec93fbc85d99d15400bc6115ffc21d44fdf6972b40ccb05fe6f9" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args,
                         "-DENABLE_DATE_TESTING=OFF",
                         "-DUSE_SYSTEM_TZ_DB=ON",
                         "-DBUILD_SHARED_LIBS=ON",
                         "-DBUILD_TZ_LIB=ON"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "date/tz.h"
      #include <iostream>

      int main() {
        auto t = date::make_zoned(date::current_zone(), std::chrono::system_clock::now());
        std::cout << t << std::endl;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-L#{lib}", "-ldate-tz", "-o", "test"
    system "./test"
  end
end
