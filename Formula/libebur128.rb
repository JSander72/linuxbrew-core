class Libebur128 < Formula
  desc "Library implementing the EBU R128 loudness standard"
  homepage "https://github.com/jiixyj/libebur128"
  url "https://github.com/jiixyj/libebur128/archive/v1.2.6.tar.gz"
  sha256 "baa7fc293a3d4651e244d8022ad03ab797ca3c2ad8442c43199afe8059faa613"
  license "MIT"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "99450597a660d645800d8d0488b657efee8d7ff9b886a80f964fe3394c8a2552"
    sha256 cellar: :any,                 big_sur:       "43567ee920b45921fb0d7787f40d3274ff42360c3048df470aee33be902694e7"
    sha256 cellar: :any,                 catalina:      "a9612342890303e8859ee23c7ce8d154f1d3eb134158322aa4ca0968d471281a"
    sha256 cellar: :any,                 mojave:        "ebe29eb9b5918eabf720410feb2ac711f5b062458e1d3129ffd29fb7da0f66b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0bf65fdc840360e92745ca371c9fb8c2654ec66df51a8909732b78f7e3090501" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "speex"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <ebur128.h>
      int main() {
        ebur128_init(5, 44100, EBUR128_MODE_I);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lebur128", "-o", "test"
    system "./test"
  end
end
