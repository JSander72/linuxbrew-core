class Shtool < Formula
  desc "GNU's portable shell tool"
  homepage "https://www.gnu.org/software/shtool/"
  url "https://ftp.gnu.org/gnu/shtool/shtool-2.0.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/shtool/shtool-2.0.8.tar.gz"
  sha256 "1298a549416d12af239e9f4e787e6e6509210afb49d5cf28eb6ec4015046ae19"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7d8d8aad608219d2b3339f2b629140a52526992ca1d68e0a2a31f3764adc1237"
    sha256 cellar: :any_skip_relocation, big_sur:       "3b414c1d021d5c209412a8162722017490d3566176272e00340a249ba06adf4e"
    sha256 cellar: :any_skip_relocation, catalina:      "e2f7c7a3b0b39b0b9d161e503310b09443cc8e4dc5283dce371afa0b4d87094a"
    sha256 cellar: :any_skip_relocation, mojave:        "7d9087a21cd6724aa82694ceca768d3044d5ab854c5ba95ae04146b3b83c2bf5"
    sha256 cellar: :any_skip_relocation, high_sierra:   "fc22505f6424dece01dcdee55907eebcb490a299763f2f217511fa14c5927711"
    sha256 cellar: :any_skip_relocation, sierra:        "172a4e2c133efcc6235aa3901bbc89ea11c48cfa70833fe67801240236d1757d"
    sha256 cellar: :any_skip_relocation, el_capitan:    "17dcf1289dd178b75b670d8061d54e4b2004feeb7de0d9e1ea43ffb46220e4fd"
    sha256 cellar: :any_skip_relocation, yosemite:      "de69e23a1e88799c78891298045bd8f79ef67ee48b7609fa065c7acdc1ddbde4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ff3004ffa49fb1f5343e0378aef09f5fdd042383d1960f2c30384c647e251b2" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "Hello World!", pipe_output("#{bin}/shtool echo 'Hello World!'").chomp
  end
end
