class Librasterlite < Formula
  desc "Library to store and retrieve huge raster coverages"
  homepage "https://www.gaia-gis.it/fossil/librasterlite/index"
  url "https://www.gaia-gis.it/gaia-sins/librasterlite-sources/librasterlite-1.1g.tar.gz"
  sha256 "0a8dceb75f8dec2b7bd678266e0ffd5210d7c33e3d01b247e9e92fa730eebcb3"
  license any_of: ["MPL-1.1", "GPL-2.0-or-later", "LGPL-2.1-or-later"]
  revision 8

  livecheck do
    skip "No longer developed"
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "9a685c2da2eca32a3b8e277e224465cb37c896717043407e64bcf54dbbe2fe67"
    sha256 cellar: :any,                 big_sur:       "cf093e2b4e2d5e1e86f089d0dd47cf9fcb7197e2f7028cedc728ce174e5abeaa"
    sha256 cellar: :any,                 catalina:      "87bda7a32b6106dd10a0a7b69ab9e2eb7795d72f09be14a264e3cf57c37706e0"
    sha256 cellar: :any,                 mojave:        "58f04df469c79fdf8e57077e7ed2226bca0ebda941b527950baefc792df365ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4a89ecdb42fc1f5b12bd528b08d3c0c1bf0db8585a5109af78087c898293f1a9" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libgeotiff"
  depends_on "libpng"
  depends_on "libspatialite"
  depends_on "sqlite"

  def install
    # Ensure Homebrew SQLite libraries are found before the system SQLite
    sqlite = Formula["sqlite"]
    ENV.append "LDFLAGS", "-L#{sqlite.opt_lib} -lsqlite3"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
