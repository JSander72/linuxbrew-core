class Kona < Formula
  desc "Open-source implementation of the K programming language"
  homepage "https://github.com/kevinlawler/kona"
  url "https://github.com/kevinlawler/kona/archive/Win64-20201009.tar.gz"
  sha256 "ec00734f36e966dd8b16e3752bee963a85b9ad415a4f1b200ae7ca28a3ad4d37"
  license "ISC"
  head "https://github.com/kevinlawler/kona.git"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/(?:Win(?:64)?[._-])?v?(\d+(?:\.\d+)*)[^"' >]*["' >]}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "69c7319589e0875a896e82df7a92fcb6be310dd0ce9cd431efb5e975234098e6"
    sha256 cellar: :any_skip_relocation, big_sur:       "ec3ffc9d3cbedb40a58f9932aa77d11126aa9d0415e4cabf19f367e250f30296"
    sha256 cellar: :any_skip_relocation, catalina:      "4d0adcc97354ca21c78d666906a718fa2dca47ca5cade99387750e8bf74f12c8"
    sha256 cellar: :any_skip_relocation, mojave:        "47267596e8da2d49e5f9527896a81cc5987cb993991d7e10e941bd5839fbc2e7"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e40a7ad668c3363a1ae1ab4fbc29729d2eff833b8975e1f40239c9d071adc64d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e6f6023371a65ae5462a8326abafd6ae37c3c8c754e4eb471a139766d4857fa" # linuxbrew-core
  end

  def install
    system "make"
    bin.install "k"
  end

  test do
    assert_match "Hello, world!", pipe_output("#{bin}/k", '`0: "Hello, world!"')
  end
end
