class Ddate < Formula
  desc "Converts boring normal dates to fun Discordian Date"
  homepage "https://github.com/bo0ts/ddate"
  url "https://github.com/bo0ts/ddate/archive/v0.2.2.tar.gz"
  sha256 "d53c3f0af845045f39d6d633d295fd4efbe2a792fd0d04d25d44725d11c678ad"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f45b9a3b64d14ae95d1aabb359535c7394fbb9781618992e0d8987009d1b306b"
    sha256 cellar: :any_skip_relocation, big_sur:       "9e7f00a11029e70caa333a3c33367e564631fcea1d08b36f02437af7b03f810c"
    sha256 cellar: :any_skip_relocation, catalina:      "2b9be177e37cb4650bae50a9527315e700592bdd8a5546cfb7b40cf201bb680c"
    sha256 cellar: :any_skip_relocation, mojave:        "bac9bcfe773de4c34915a353fe6f8808ac26f8253d0da9d43ab9787b4988ff44"
    sha256 cellar: :any_skip_relocation, high_sierra:   "31a72f135768fdf09ddc40539e3860e3489cf478cca07f6af71d8d3428447a78"
    sha256 cellar: :any_skip_relocation, sierra:        "61be1f5fc044574ede464807fba1e092bc165932a909a357f5cd71b0cbfd4726"
    sha256 cellar: :any_skip_relocation, el_capitan:    "fe87fe60ad1e8cbff1ebbcefd8be0f6f8ec87013a91e6385adbde0aebd45edea"
    sha256 cellar: :any_skip_relocation, yosemite:      "ad575dd84b5d2ac8395c9cd11c4ef811f28f105eb81510369bb33078164ec2e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b4632697240a4e7b6dfb7a27a0ace8a692a1b31702fbe1c23e225f3815a76f9" # linuxbrew-core
  end

  def install
    system ENV.cc, "ddate.c", "-o", "ddate"
    bin.install "ddate"
    man1.install "ddate.1"
  end

  test do
    output = shell_output("#{bin}/ddate 20 6 2014").strip
    assert_equal "Sweetmorn, Confusion 25, 3180 YOLD", output
  end
end
