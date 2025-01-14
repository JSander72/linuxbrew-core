class Lpc21isp < Formula
  desc "In-circuit programming (ISP) tool for several NXP microcontrollers"
  homepage "https://lpc21isp.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/lpc21isp/lpc21isp/1.97/lpc21isp_197.tar.gz"
  version "1.97"
  sha256 "9f7d80382e4b70bfa4200233466f29f73a36fea7dc604e32f05b9aa69ef591dc"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b6f26711684bfbf3ddde4574aab70336278338b206a5fe3e278d868903bd8910"
    sha256 cellar: :any_skip_relocation, big_sur:       "47edc941f73249c62b66a4d795bcec7c2916082ab60f1cc1e1c0c46ebe99b694"
    sha256 cellar: :any_skip_relocation, catalina:      "e5231b41e3d08d835d4c3a457b594c60576c42802347c01555acc94c04067d94"
    sha256 cellar: :any_skip_relocation, mojave:        "bf40168803e67310ecdf47f5ad8f1c8738d6775a91b99b5cda221fdc85e65a51"
    sha256 cellar: :any_skip_relocation, high_sierra:   "fa1c7462808e18f1b2a180c5db6c0ccd4481b5c0d29c5e834dd1feb888c96dba"
    sha256 cellar: :any_skip_relocation, sierra:        "68c3756fd99268814cfdc861e971d1201bac42bf5b922ab37119fcb082c86a1c"
    sha256 cellar: :any_skip_relocation, el_capitan:    "c12b33d514be2490a3a5bb9d3c1f8468e7e24d13eee0a636a9d067f486af59fc"
    sha256 cellar: :any_skip_relocation, yosemite:      "10deab3f8de3cb88b27ea38344ba7c641b758faf45f9a247f3fca968f6db456b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf85362b4d7e620016c81503c5b60d43045bde99fe5130a3946179ce0a7b0275" # linuxbrew-core
  end

  def install
    system "make"
    bin.install ["lpc21isp"]
  end
end
