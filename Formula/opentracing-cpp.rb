class OpentracingCpp < Formula
  desc "OpenTracing API for C++"
  homepage "https://opentracing.io/"
  url "https://github.com/opentracing/opentracing-cpp/archive/v1.6.0.tar.gz"
  sha256 "5b170042da4d1c4c231df6594da120875429d5231e9baa5179822ee8d1054ac3"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any, big_sur:      "1a904785b31fe03fc39333e81dc06e815b649c92062e23a99cf24137a013227b"
    sha256 cellar: :any, catalina:     "151a5af54448492f668979eb3a0e9fb92e2e1a99cb6766ba3985a9a88f26526a"
    sha256 cellar: :any, mojave:       "5a10c35e98785ee6567c241e845e3fd24a2fa52f15ade1d4e6a91f939752bd8c"
    sha256 cellar: :any, high_sierra:  "7747ffc077d879fbbbf4509e65fcfc154f238c9c92482bf94d1fb176156be563"
    sha256 cellar: :any, x86_64_linux: "dc35c641ee16ae5babb0ca1faae6ff117f1c19d3c0a1479a00c8a4b8043e03ab" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "example/tutorial/tutorial-example.cpp"
    pkgshare.install "example/tutorial/text_map_carrier.h"
  end

  test do
    system ENV.cxx, "#{pkgshare}/tutorial-example.cpp", "-std=c++11", "-L#{lib}", "-I#{include}",
                    "-lopentracing", "-lopentracing_mocktracer", "-o", "tutorial-example"
    system "./tutorial-example"
  end
end
