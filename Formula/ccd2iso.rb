class Ccd2iso < Formula
  desc "Convert CloneCD images to ISO images"
  homepage "https://ccd2iso.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ccd2iso/ccd2iso/ccd2iso-0.3/ccd2iso-0.3.tar.gz"
  sha256 "f874b8fe26112db2cdb016d54a9f69cf286387fbd0c8a55882225f78e20700fc"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a5744e3d028a63b27e0a6b9c8f0c839effbd4385f41af50bb44725d5310b61ee"
    sha256 cellar: :any_skip_relocation, big_sur:       "1bd1d2fedb8cd0bfe682f80bffeced5c7e273a2d24c2dd01a7b777e4d3ee0115"
    sha256 cellar: :any_skip_relocation, catalina:      "741bb587861701e9900ede511e2db1e73815428eb2f0f2c697313dad70609853"
    sha256 cellar: :any_skip_relocation, mojave:        "710ddc04aac005477e9aaa73e882bc1d8cbe96412ac949ff4a7501c6a53ca018"
    sha256 cellar: :any_skip_relocation, high_sierra:   "9d33b636be5f43c1e40955323c2f5d4a02d603c990aab2c89e98b5cb16a5cf93"
    sha256 cellar: :any_skip_relocation, sierra:        "c855496f0265a8f806228cddc1c15d5a1d6e7186f4bb43c0a317a6256d8e8e85"
    sha256 cellar: :any_skip_relocation, el_capitan:    "e74b2779ef3d832bc899422285c2d03ea33aa6ab979ca835914343999b444671"
    sha256 cellar: :any_skip_relocation, yosemite:      "020f198fa4476dc640fa14e8efa7ad04985143e7007c45610b890bdc7db47599"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df95c15a655c42ab3e041f2b4782b90e783f4ad341108e4866f8a3f03adf87f2" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match(
      /^#{Regexp.escape(version)}$/, shell_output("#{bin}/ccd2iso --version")
    )
  end
end
