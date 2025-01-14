class YamlCpp < Formula
  desc "C++ YAML parser and emitter for YAML 1.2 spec"
  homepage "https://github.com/jbeder/yaml-cpp"
  url "https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.6.3.tar.gz"
  sha256 "77ea1b90b3718aa0c324207cb29418f5bced2354c2e483a9523d98c3460af1ed"
  license "MIT"
  revision 1

  bottle do
    sha256 cellar: :any, arm64_big_sur: "3ef6d98fb044cfbb307037287e6c14914f28afc725c964998f894cd8b619ac15"
    sha256 cellar: :any, big_sur:       "a4cd13489c2e397883162dad15f3a08adb434601ba2dd84d124c141f64f719fc"
    sha256 cellar: :any, catalina:      "7cb356c020e5e1f2a32d5b2721516b9079cc4518556a0344fd498df6abe04731"
    sha256 cellar: :any, mojave:        "ab76f2d444f7948c73f102588d079e4a3a0c758974f42cec1bffa31e80ca7bff"
    sha256 cellar: :any, high_sierra:   "824351b703802346eeb47a3a0acdbf438327cc1cb77ef4a342493a938574c6d6"
    sha256 cellar: :any, x86_64_linux:  "1b156beecfaa03bcd03512a5074cacd6d7eaaf4767fa8232badcd7c2edab6c95" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args, "-DYAML_BUILD_SHARED_LIBS=ON",
                                          "-DYAML_CPP_BUILD_TESTS=OFF"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <yaml-cpp/yaml.h>
      int main() {
        YAML::Node node  = YAML::Load("[0, 0, 0]");
        node[0] = 1;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-L#{lib}", "-lyaml-cpp", "-o", "test"
    system "./test"
  end
end
