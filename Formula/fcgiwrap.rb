class Fcgiwrap < Formula
  desc "CGI support for Nginx"
  homepage "https://www.nginx.com/resources/wiki/start/topics/examples/fcgiwrap/"
  url "https://github.com/gnosek/fcgiwrap/archive/1.1.0.tar.gz"
  sha256 "4c7de0db2634c38297d5fcef61ab4a3e21856dd7247d49c33d9b19542bd1c61f"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "b7f23b86cfdfcf813fadf2e7a3c228fa70476bae53c5617f20d810e07c7c355b"
    sha256 cellar: :any, big_sur:       "bd98b43c74955117affa9b619376f09eae18890dea9b4bdb3ea81b70c44024ac"
    sha256 cellar: :any, catalina:      "c8d117b2a7fed48905548381120a0ce80e6250ea434d8f62dde18fd12542ca04"
    sha256 cellar: :any, mojave:        "c871c0641217165e88fcdde225c8058a62d043083e434fe3b371c0b7d58ea45f"
    sha256 cellar: :any, high_sierra:   "92140b4ed813b4a718ec9ed035b664fe744a6ae860a4b533ed7425b014e25f22"
    sha256 cellar: :any, sierra:        "ed81f5b0cec39f7138a877cea2a0e397007d3271393805af53739b837537bd0f"
    sha256 cellar: :any, el_capitan:    "c0a70c3cc726788dfac52d8b23c79c1a4ef31a8c7e1418ac335cfe182b94f05d"
    sha256 cellar: :any, yosemite:      "ea03eeafcd71e07c2e608bc974a00cf642b253de24eb7bd587155c89db2fffad"
    sha256 cellar: :any, x86_64_linux:  "085d05ae121ccf4e9fbd71acafb4687b44648b878628780c5bfeed3d8f6101ee" # linuxbrew-core
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "fcgi"

  def install
    system "autoreconf", "-i"
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end
end
