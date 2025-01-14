class Crunch < Formula
  desc "Wordlist generator"
  homepage "https://sourceforge.net/projects/crunch-wordlist/"
  url "https://downloads.sourceforge.net/project/crunch-wordlist/crunch-wordlist/crunch-3.6.tgz"
  sha256 "6a8f6c3c7410cc1930e6854d1dadc6691bfef138760509b33722ff2de133fe55"
  license "GPL-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dfc7c5b56963d28a58c64a2a28d0c19b61dfce141b83c9facaad0d8d606949b2"
    sha256 cellar: :any_skip_relocation, big_sur:       "9cd9d5ae5afb6b6223e720b99d30990f1884cd8ed4e0b5654a9ab2d72cc4d132"
    sha256 cellar: :any_skip_relocation, catalina:      "67570938790b20aaabcb31c8ac86d4356702b87ce2ae8ea01d19553f531397a6"
    sha256 cellar: :any_skip_relocation, mojave:        "ad3bd04ba230c46df88ab4ab7a74efa3182cd65b804b65a28a327f74700641e8"
    sha256 cellar: :any_skip_relocation, high_sierra:   "c59cb398b0ed4f28e8d56c49709991f5ea61b61bad4d672f1a481730948cdeb0"
    sha256 cellar: :any_skip_relocation, sierra:        "737d46b90aaa933abe03e111ece79e3f6a0ecb372cc1903b9dba3a33208111b9"
    sha256 cellar: :any_skip_relocation, el_capitan:    "84c0c275e63cc5c27fd468587f67ae5f1ab31a3923fe2eda27b4e33477356844"
    sha256 cellar: :any_skip_relocation, yosemite:      "406d94f00713b83bbf41b36453605a5f85f154f88aec9b3ae23e7646ddcc03c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "28d49ef615d8f26edf0fec888973fffb2649332d84acc0f34c8faa43b294dda8" # linuxbrew-core
  end

  def install
    system "make", "CC=#{ENV.cc}", "LFS=-D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"

    bin.install "crunch"
    man1.install "crunch.1"
    share.install Dir["*.lst"]
  end

  test do
    system "#{bin}/crunch", "-v"
  end
end
