class Libxmu < Formula
  desc "X.Org: X miscellaneous utility routines library"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXmu-1.1.3.tar.bz2"
  sha256 "9c343225e7c3dc0904f2122b562278da5fed639b1b5e880d25111561bac5b731"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "c0efd6d85d0f2738138ce77b3a5eb18cfcc984f8cded38351670a1066f00d732"
    sha256 cellar: :any, big_sur:       "2b2e329a7ebf57e09d29296db2763f2ea105ce73082f2c11d4c29f9da32c0070"
    sha256 cellar: :any, catalina:      "ff33cd2f865f77d04ad861dd5e10784842511050c754e9bd772ab81b2e1c6918"
    sha256 cellar: :any, mojave:        "a437eedd57edefe94c7a4d7cb30ac03d5ea6852f7a6ba6be33e12c839cde6ac6"
    sha256 cellar: :any, high_sierra:   "24ca27eaf60f6dfe9d35d61ff4edc5ba7b9e04e3d9efc9938fe5eb905057c8e6"
    sha256 cellar: :any, x86_64_linux:  "4e8b5ed3d29011b11d5dc7689ab2ba1f256c85beded37b838de4b4534236bc65" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libxext"
  depends_on "libxt"

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
      #include "X11/Xlib.h"
      #include "X11/Xmu/Xmu.h"

      int main(int argc, char* argv[]) {
        XmuArea area;
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lXmu"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
