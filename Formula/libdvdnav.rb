class Libdvdnav < Formula
  desc "DVD navigation library"
  homepage "https://www.videolan.org/developers/libdvdnav.html"
  url "https://download.videolan.org/pub/videolan/libdvdnav/6.1.1/libdvdnav-6.1.1.tar.bz2"
  sha256 "c191a7475947d323ff7680cf92c0fb1be8237701885f37656c64d04e98d18d48"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "e3ea0ddda7b96b799c2a67fd6687c25679001e2dc3893f200c70d4a599bc3996"
    sha256 cellar: :any,                 big_sur:       "cabd25ecc0df8a3729e7196737e56041d8d6b9f369972d66de1ade19b4bfbafb"
    sha256 cellar: :any,                 catalina:      "ded7214f830c32676e5a64c2836b5498e44aeaa4967c5753a89c48af66edeaf7"
    sha256 cellar: :any,                 mojave:        "4fe58e754e7174ef7013a89a0620e05b8131bd50ed1de2c54e8b837db81fc4de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "617aa56d6c050c571662c753292b76dfaead0ca4538d1c3e66da6f401d03b847" # linuxbrew-core
  end

  head do
    url "https://code.videolan.org/videolan/libdvdnav.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libdvdread"

  def install
    system "autoreconf", "-if" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
