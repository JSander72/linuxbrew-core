class Dvdauthor < Formula
  desc "DVD-authoring toolset"
  homepage "https://dvdauthor.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/dvdauthor/dvdauthor-0.7.2.tar.gz"
  sha256 "3020a92de9f78eb36f48b6f22d5a001c47107826634a785a62dfcd080f612eb7"
  revision 3

  livecheck do
    url :stable
    regex(%r{url=.*?/dvdauthor[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "a0b0c601eb1ec9de60de448cab11217c63febd18afd7a9ee6207fdb1427593f5"
    sha256 cellar: :any,                 big_sur:       "c6405e471ac402f1b0ec1e2fbbb2ee3eb4be9dd82f0ef5b8991339928ff2fdb0"
    sha256 cellar: :any,                 catalina:      "7ebcd748eb4eba1876bd1cb181fa6ec679773dbf753be805845904b69685ee11"
    sha256 cellar: :any,                 mojave:        "5da2d90859c186ea0795b18210ef2722f96bfbb16f53d3a0cb0aa89084026ce0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "afdfb291b73b40769bace04dc4c172729aeee6dad5f8e4c3efdb1e298af857ee" # linuxbrew-core
  end

  # Dvdauthor will optionally detect ImageMagick or GraphicsMagick, too.
  # But we don't add either as deps because they are big.

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "libdvdread"
  depends_on "libpng"
  depends_on "libxml2" if MacOS.version <= :el_capitan

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    ENV.deparallelize # Install isn't parallel-safe
    system "make", "install"
  end

  test do
    assert_match "VOBFILE", shell_output("#{bin}/dvdauthor --help 2>&1", 1)
  end
end
