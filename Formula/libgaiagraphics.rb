class Libgaiagraphics < Formula
  desc "Library supporting common-utility raster handling"
  homepage "https://www.gaia-gis.it/fossil/libgaiagraphics/index"
  url "https://www.gaia-gis.it/gaia-sins/gaiagraphics-sources/libgaiagraphics-0.5.tar.gz"
  sha256 "ccab293319eef1e77d18c41ba75bc0b6328d0fc3c045bb1d1c4f9d403676ca1c"
  revision 8

  livecheck do
    url "https://www.gaia-gis.it/gaia-sins/gaiagraphics-sources/"
    regex(/href=.*?libgaiagraphics[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "6623ec87d81dc19a855c81549b00b07cd9a7f931ad40ba0cf2e8f9fcebb03b40"
    sha256 cellar: :any,                 big_sur:       "865d8050b42bc24609c47e17347c78b9cbdc0d9b585076931b58b94097076e16"
    sha256 cellar: :any,                 catalina:      "7471281583cae58d19538fd2bb5bda8e251a6bee797c4c5191820b61537f4109"
    sha256 cellar: :any,                 mojave:        "0c0a8eb90a920ef286d534f0ba81aea1e009c3abc6eaff86be25e906aa5795d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "351aec1903c85c25a28f7fadd4ab871f6ba0491ef46c90f15c15102fd4239cea" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "jpeg"
  depends_on "libgeotiff"
  depends_on "libpng"
  depends_on "proj@7"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
