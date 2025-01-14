class Pngcheck < Formula
  desc "Print info and check PNG, JNG, and MNG files"
  homepage "http://www.libpng.org/pub/png/apps/pngcheck.html"
  url "http://www.libpng.org/pub/png/src/pngcheck-3.0.3.tar.gz"
  sha256 "c36a4491634af751f7798ea421321642f9590faa032eccb0dd5fb4533609dee6"
  license all_of: ["MIT", "GPL-2.0-or-later"]

  livecheck do
    url :homepage
    regex(/href=.*?pngcheck[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a009523aaa8a5c8eb879fda99829ce1007b682b2caa2413af78112aa94ee741c"
    sha256 cellar: :any_skip_relocation, big_sur:       "8a025005cde9e8423606279cea498d921810f2334fe17a7bf23a1eba6ee54aef"
    sha256 cellar: :any_skip_relocation, catalina:      "a4256bacc1a8025fa298b35d93af3ecf213449ab9118106530cdd29455293ead"
    sha256 cellar: :any_skip_relocation, mojave:        "6423830817d3166ce48ea9cb88f3a83f1f7e381d8a1039c4db153e465450d5c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ac6e33fd8aa8ab6b81f265338dcd7038e81dc3b382881c06b1a864ac797538a" # linuxbrew-core
  end

  uses_from_macos "zlib"

  def install
    system "make", "-f", "Makefile.unx", "ZINC=", "ZLIB=-lz"
    bin.install %w[pngcheck pngsplit png-fix-IDAT-windowsize]
  end

  test do
    system bin/"pngcheck", test_fixtures("test.png")
  end
end
