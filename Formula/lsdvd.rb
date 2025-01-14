class Lsdvd < Formula
  desc "Read the content info of a DVD"
  homepage "https://sourceforge.net/projects/lsdvd"
  url "https://downloads.sourceforge.net/project/lsdvd/lsdvd/lsdvd-0.17.tar.gz"
  sha256 "7d2c5bd964acd266b99a61d9054ea64e01204e8e3e1a107abe41b1274969e488"
  revision 4

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "d581725cf2628d8c123d3f6f54d1baf06cb33362d9f6dc7d033a4f7768729474"
    sha256 cellar: :any,                 big_sur:       "0d5d1a272ba88ff70ce68ddc35fca9811e2ca5222696373aaf3d2ffc0126a471"
    sha256 cellar: :any,                 catalina:      "986e89fe0980a78d7d7ef18fd646d3176edbaa7fd6531c38f698d3bdf2aed5dd"
    sha256 cellar: :any,                 mojave:        "66cbfc0e273fc63813c4948638ab849357ef9d3f72ce5b6322a27f5f614507f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "13f70bd346583cfb8d8f28758cd3cc5c33c917144103dc75db8e2dd8eeedb279" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libdvdcss"
  depends_on "libdvdread"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system bin/"lsdvd", "--help"
  end
end
