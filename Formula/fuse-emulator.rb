class FuseEmulator < Formula
  desc "Free Unix Spectrum Emulator"
  homepage "https://fuse-emulator.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/fuse-emulator/fuse/1.6.0/fuse-1.6.0.tar.gz"
  sha256 "3a8fedf2ffe947c571561bac55a59adad4c59338f74e449b7e7a67d9ca047096"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/fuse[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 arm64_big_sur: "e90d4659088b2fd702f5b9fdd65971f40e91468b539d1f6bba5405f09177cd31"
    sha256 big_sur:       "36e52532b87822d39bcfc3df322e16cc1bce3d15e3c4898df3fb19e603627979"
    sha256 catalina:      "569522bf7f64bec6a0c0ebbd50658798830fa4509d1720a01f2a9404d5d44cc9"
    sha256 mojave:        "4431c55c622edab217e5e896e9718895747ccb8546dd4251c4457c327a0c6ae0"
    sha256 x86_64_linux:  "6d29d60fffb6b1bc9cc49afa909a5e58f8f8428c0cd25ccf2fae5b56bff44ad8" # linuxbrew-core
  end

  head do
    url "https://svn.code.sf.net/p/fuse-emulator/code/trunk/fuse"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libpng"
  depends_on "libspectrum"
  depends_on "sdl"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-sdltest",
                          "--with-sdl",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/fuse", "--version"
  end
end
