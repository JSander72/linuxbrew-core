class Vttest < Formula
  desc "Test compatibility of VT100-compatible terminals"
  homepage "https://invisible-island.net/vttest/"
  url "https://invisible-mirror.net/archives/vttest/vttest-20210210.tgz"
  sha256 "0f98a2e305982915f1520984c3e8698e3acd508ee210711528c89f5a7ea7f046"
  license "BSD-3-Clause"

  livecheck do
    url "https://invisible-mirror.net/archives/vttest/"
    regex(/href=.*?vttest[._-]v?(\d+(?:[.-]\d+)*)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5bd298d05ad47843648ba8f8b8825614d647b495e4c09c34e00e4947eff9a016"
    sha256 cellar: :any_skip_relocation, big_sur:       "bcaa7bfde1caffa18b43a357d684b92e6cfc1db34e5f77a47fb4be22f9ed2051"
    sha256 cellar: :any_skip_relocation, catalina:      "07691c12896f2adfd4cae9ddd7f04b3fcd67ccd6727fe59b7ba79200e7f4961c"
    sha256 cellar: :any_skip_relocation, mojave:        "a73bba40a8459292c25b2999286c29278c9789cbaed70e5382fb1f2b116a0b21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2234edbdf8b69ac119a1cb54cc2926836c4da1999860a77ebcaa8835e7d87b1" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output(bin/"vttest -V")
  end
end
