class Libftdi0 < Formula
  desc "Library to talk to FTDI chips"
  homepage "https://www.intra2net.com/en/developer/libftdi"
  url "https://www.intra2net.com/en/developer/libftdi/download/libftdi-0.20.tar.gz"
  sha256 "3176d5b5986438f33f5208e690a8bfe90941be501cc0a72118ce3d338d4b838e"

  livecheck do
    url "https://www.intra2net.com/en/developer/libftdi/download.php"
    regex(/href=.*?libftdi[._-]v?(0(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 2
    sha256 cellar: :any, arm64_big_sur: "0c48950d5292b7eca6aa02488d53792cc2b83b3bb0aa657cce08d10141eba5d2"
    sha256 cellar: :any, big_sur:       "710564aabb66bbb9b82f0fccd149fdf40f6e1a7886bd624829a07a9c41752e63"
    sha256 cellar: :any, catalina:      "064e2f32a4a8959f2a489611c931beac426f509a8299bbcdd03871b1d5f5859e"
    sha256 cellar: :any, mojave:        "c3238e8f4458ead2c663c8d5b48e2052d3ee606b75278a9839546fd2e6c7de49"
    sha256 cellar: :any, high_sierra:   "ef988a7e074542fb5df2c8e803b19e9d20b8602e3899833b10d6cdf862b4c5be"
    sha256 cellar: :any, sierra:        "f89e79f5eb94d55e130dcc55deca87f1241b386bf45070dda52c2c22707ead15"
    sha256 cellar: :any, el_capitan:    "8fbc5ef456600b919430d86dd4e7090ae1f1064e4a51d631ab9bd7b39887ead2"
    sha256 cellar: :any, yosemite:      "92ecdb3a110e1abcba05561f0def8e573d1f8174d4e04247375dd5cd47d3bc24"
    sha256 cellar: :any, x86_64_linux:  "63247287fa8c88011bb008a199830bbfeaa23bd3dd572188fba7df1697508000" # linuxbrew-core
  end

  depends_on "libusb-compat"

  conflicts_with "cspice", because: "both install `simple` binaries"
  conflicts_with "openhmd", because: "both install `simple` binaries"

  def install
    mkdir "libftdi-build" do
      system "../configure", "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/libftdi-config", "--version"
  end
end
