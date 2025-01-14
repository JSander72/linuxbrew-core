class Libtrng < Formula
  desc "Tina's Random Number Generator Library"
  homepage "https://www.numbercrunch.de/trng/"
  url "https://github.com/rabauke/trng4/archive/refs/tags/v4.24.tar.gz"
  sha256 "92dd7ab4de95666f453b4fef04827fa8599d93a3e533cdc604782c15edd0c13c"
  license "BSD-3-Clause"
  head "https://github.com/rabauke/trng4.git"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "9cfa0851919690b182b5cd227c71e77b7f07f5179ff5d06b52894fb98ca131df"
    sha256 cellar: :any,                 big_sur:       "c97a7c825b5a6614dd771cef5f0aebdadb70f5b619e19aa446afff5072ec236d"
    sha256 cellar: :any,                 catalina:      "044b708b751a88a22b95e4b75c47a8125fe017d6e69ea39c1177c9bc06c0de85"
    sha256 cellar: :any,                 mojave:        "85e7a9b91ec9df836ce6127af7ca09deffd9052136c34ae1b0d3e310467eddc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bad44ba108f2de0bba7033a4469c9397ec4204dc0d933bec8a5f1c81cbc3e5ea" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <trng/yarn2.hpp>
      #include <trng/normal_dist.hpp>
      int main()
      {
        trng::yarn2 R;
        trng::normal_dist<> normal(6.0, 2.0);
        (void)normal(R);
        return 0;
      }
    EOS
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", "-I#{include}", "-L#{lib}", "-ltrng4"
    system "./test"
  end
end
