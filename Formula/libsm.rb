class Libsm < Formula
  desc "X.Org: X Session Management Library"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libSM-1.2.3.tar.bz2"
  sha256 "2d264499dcb05f56438dee12a1b4b71d76736ce7ba7aa6efbf15ebb113769cbb"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "cea6bfd718aebbc61b9c2cc43e107af7872177700366224459d1ba67e570f8b7"
    sha256 cellar: :any, big_sur:       "6b764ce643e30d5d152eede7592e544fbe1baf4ced75a92589d5e6242dfa55cc"
    sha256 cellar: :any, catalina:      "0cfe06bc49f376e5f770e378097ecf7e261db7d4b3c51740ddfcb86df36815af"
    sha256 cellar: :any, mojave:        "35cca1d4348481da2d35f1c91882e9b32604480a15b679efed3209f74ff8d78b"
    sha256 cellar: :any, high_sierra:   "927db02bae25120237de025a8219899d9ed69d8f4669c6662e170a4e0ce9eee2"
    sha256 cellar: :any, x86_64_linux:  "a950f4644e491d2fcadb37db2e96554d5bae2f5446dce62c57cf7398b89645d1" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "xtrans" => :build
  depends_on "libice"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-docs=no
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "X11/SM/SMlib.h"

      int main(int argc, char* argv[]) {
        SmProp prop;
        return 0;
      }
    EOS
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
