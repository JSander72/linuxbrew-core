class Toilet < Formula
  desc "Color-based alternative to figlet (uses libcaca)"
  homepage "http://caca.zoy.org/wiki/toilet"
  url "http://caca.zoy.org/raw-attachment/wiki/toilet/toilet-0.3.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/t/toilet/toilet_0.3.orig.tar.gz"
  sha256 "89d4b530c394313cc3f3a4e07a7394fa82a6091f44df44dfcd0ebcb3300a81de"

  license "WTFPL"
  livecheck do
    url "http://caca.zoy.org/raw-attachment/wiki/toilet/"
    regex(/href=.*?toilet[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end
  bottle do
    sha256 arm64_big_sur: "962eed08eba86fe1f35bdc00f6cf7d119639b93a305451f0283517c5b89df15a"
    sha256 big_sur:       "6656e1a05049339433307a78ae8df879f45903c179642361e0ef24331e3e44c4"
    sha256 catalina:      "816162aa8f967f14e6db8f9b48024ef5119c04955575299e02fe88b2b0158ac6"
    sha256 mojave:        "27c9e1fe38ec012c5dd9199c8100d49c56e386c65c336a4fbcaaa25a9341cab2"
    sha256 high_sierra:   "dda87a313d7398dd3157ca74d752b3d364647fc56c3238fb5bd320fcc904ebd5"
    sha256 sierra:        "24008d251358aa73e7e597b203e360857fec5b88278e6ea6de08d4eef3865f80"
    sha256 el_capitan:    "93822fde3d2e69f46143dcb9d8551e7e4301c7a470ae53b3fda8ec6cb44584dd"
    sha256 yosemite:      "7362333eea743740a9cdb064c5a74829e37b3f15645797622bb283b9cf3f3b1a"
    sha256 x86_64_linux:  "e4bf79430421dcc707d3f7ad0b49020ece999ae67ea00e9fb50c0a45299037d9" # linuxbrew-core
  end

  head do
    url "https://github.com/cacalabs/toilet.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libcaca"

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/toilet", "--version"
  end
end
