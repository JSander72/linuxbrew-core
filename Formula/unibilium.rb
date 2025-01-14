class Unibilium < Formula
  desc "Very basic terminfo library"
  homepage "https://github.com/neovim/unibilium"
  url "https://github.com/neovim/unibilium/archive/v2.1.1.tar.gz"
  sha256 "6f0ee21c8605340cfbb458cbd195b4d074e6d16dd0c0e12f2627ca773f3cabf1"
  license "LGPL-3.0-or-later"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "312df6bed7c751800af40d85f409f7b96296aa0968cc9a0d415f9fe4114a506c"
    sha256 cellar: :any,                 big_sur:       "6f0c7e2db3067e24f4480566d9cf80b9f47ef6099386205ca472a8ede717d3e8"
    sha256 cellar: :any,                 catalina:      "06ca0a9cc4c001e5136b14b210c7a37ff7ecb85e2f1c348a3655b325094ac697"
    sha256 cellar: :any,                 mojave:        "e2757e5acea92e205a10e738d6a084b37347a3be3e08f8a481607e9c48d22e95"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "98de0fc9960a987a555337f567a2af2b1cc7f7b3fbd9861c0418d7fff9e4a89b" # linuxbrew-core
  end

  depends_on "libtool" => :build

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <unibilium.h>
      #include <stdio.h>

      int main()
      {
        setvbuf(stdout, NULL, _IOLBF, 0);
        unibi_term *ut = unibi_dummy();
        unibi_destroy(ut);
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "test.c", "-L#{lib}", "-lunibilium", "-o", "test"
    system "./test"
  end
end
