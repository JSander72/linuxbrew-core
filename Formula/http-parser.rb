class HttpParser < Formula
  desc "HTTP request/response parser for c"
  homepage "https://github.com/nodejs/http-parser"
  url "https://github.com/nodejs/http-parser/archive/v2.9.4.tar.gz"
  sha256 "467b9e30fd0979ee301065e70f637d525c28193449e1b13fbcb1b1fab3ad224f"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "7130d0b0338eaf592eb0510251f95a8a4e580ef9ecc4eaf787ba048204639498"
    sha256 cellar: :any, big_sur:       "48d383aa989a940b3918cc83fa2bb6b5fad92c9b4c70018172d36f9e465087e3"
    sha256 cellar: :any, catalina:      "f03615a5ecb9e65d4bd7b302a8429ba9130012b092f3f42e0afd85df2bf47453"
    sha256 cellar: :any, mojave:        "b36ae811b2b72823cea4c7ab445ee2a5f628255aa169f0bc453fda1d3d520fbb"
    sha256 cellar: :any, high_sierra:   "0c6b69289fa4a8dd7ad532fcefb0848af229dcb5a64df981c03e99af2ce3acd8"
    sha256 cellar: :any, x86_64_linux:  "46f21c3eb750edef6c569bf57e42107f2fb33417e1ca5f590977b1983d26db72" # linuxbrew-core
  end

  depends_on "coreutils" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}", "INSTALL=ginstall"
    pkgshare.install "test.c"
  end

  test do
    # Set HTTP_PARSER_STRICT=0 to bypass "tab in URL" test on macOS
    system ENV.cc, pkgshare/"test.c", "-o", "test", "-L#{lib}", "-lhttp_parser",
           "-DHTTP_PARSER_STRICT=0"
    system "./test"
  end
end
