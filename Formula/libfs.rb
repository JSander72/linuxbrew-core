class Libfs < Formula
  desc "X.Org: X Font Service client library"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libFS-1.0.8.tar.bz2"
  sha256 "c8e13727149b2ddfe40912027459b2522042e3844c5cd228c3300fe5eef6bd0f"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "3509ffdca42e13e77c8b0031cef59d661f0f2213ea3367b29ebfe738f4e9a715"
    sha256 cellar: :any, big_sur:       "c12e8b46907935f4b59326c3d98372f9b4bd040e0ceb42af244a909fa5c09e17"
    sha256 cellar: :any, catalina:      "6ccad0f27601c96ffffac5229d5a25c0ece882b0faf626ae115dfd57a1ac09cb"
    sha256 cellar: :any, mojave:        "b8edb6c54600c14a791a33e7997927d394254b1212ea646ac786a667db263921"
    sha256 cellar: :any, high_sierra:   "f62ce9b989c58747a5b5764478cab8acdf021b60d2a6d306547605305ad41f04"
    sha256 cellar: :any, x86_64_linux:  "5ce12b29cb3ed2cff925ab4a77e6cab1176ddeba78e9296887817d0fdeeceac7" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "xtrans" => :build
  depends_on "xorgproto"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "X11/fonts/FSlib.h"

      int main(int argc, char* argv[]) {
        FSExtData data;
        return 0;
      }
    EOS
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
