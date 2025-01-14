class Libmicrohttpd < Formula
  desc "Light HTTP/1.1 server library"
  homepage "https://www.gnu.org/software/libmicrohttpd/"
  url "https://ftp.gnu.org/gnu/libmicrohttpd/libmicrohttpd-0.9.73.tar.gz"
  mirror "https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-0.9.73.tar.gz"
  sha256 "a37b2f1b88fd1bfe74109586be463a434d34e773530fc2a74364cfcf734c032e"
  license "LGPL-2.1-or-later"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "92216bc689b42d660f2282fcb085394033b6cfcc251f8443650ec01be4e09176"
    sha256 cellar: :any,                 big_sur:       "035f1dd8caeb642f47c82f8efeabde09d2476af9b5a73b7ef6337f0c6373090e"
    sha256 cellar: :any,                 catalina:      "61f7cd6b76713ad189ac09c59b7f798cdda9383b022c55fdd5c48da1360ef6fb"
    sha256 cellar: :any,                 mojave:        "eba382f3e0e66eb18e11bebc64c28d1adc9e1a34775a931a00ae1ff606d62f43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2acb75376102f675b6bd9f3d72ce9fa976c646e282087e1743e3c21f290a580" # linuxbrew-core
  end

  depends_on "gnutls"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-https",
                          "--prefix=#{prefix}"
    system "make", "install"
    (pkgshare/"examples").install Dir.glob("doc/examples/*.c")
  end

  test do
    cp pkgshare/"examples/simplepost.c", testpath
    inreplace "simplepost.c",
      "return 0",
      "printf(\"daemon %p\", daemon) ; return 0"
    system ENV.cc, "-o", "foo", "simplepost.c", "-I#{include}", "-L#{lib}", "-lmicrohttpd"
    assert_match(/daemon 0x[0-9a-f]+[1-9a-f]+/, pipe_output("./foo"))
  end
end
