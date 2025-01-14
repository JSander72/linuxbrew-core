class Libresample < Formula
  desc "Audio resampling C library"
  homepage "https://ccrma.stanford.edu/~jos/resample/Available_Software.html"
  url "https://deb.debian.org/debian/pool/main/libr/libresample/libresample_0.1.3.orig.tar.gz"
  sha256 "20222a84e3b4246c36b8a0b74834bb5674026ffdb8b9093a76aaf01560ad4815"
  license "LGPL-2.1"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e2b808178af8d3b7ceccc4c3323ebcf76ad0d3a152c31cbe85c68563cca80bbf"
    sha256 cellar: :any_skip_relocation, big_sur:       "623df9f095f427ee794211cd657ad1d1ff5e89f383aa304c9c94d7a27cac36a3"
    sha256 cellar: :any_skip_relocation, catalina:      "779b21b26d28a7318e67e0444b74ee5782715b523c1f79ba9bdff41c334cd312"
    sha256 cellar: :any_skip_relocation, mojave:        "7973809674c5ca9dceaf822abaf482c2a8126928140fa056168644b1196005c2"
    sha256 cellar: :any_skip_relocation, high_sierra:   "42b971ed75ad6ba1bd6879c2b7cb5fb416706ed184291d12983e46ab6c90a20c"
    sha256 cellar: :any_skip_relocation, sierra:        "b94dc206fa507bcdceb49534740c5c0dff0868a9d9333e4acd8922f22b10c912"
    sha256 cellar: :any_skip_relocation, el_capitan:    "ba2446005f2417fa81e5a5963d2273494396f8821ee95fd84ed9825342564598"
    sha256 cellar: :any_skip_relocation, yosemite:      "2f58f8b45cd7b6f89f645cb90d3b4f63dd0a28e927713f3a4664c348e3a15a21"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5cd85c8ea65ed33a5a989af48d2c3e69e6fea877af3c3993909db216b9a931a8" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    lib.install "libresample.a"
    include.install "include/libresample.h"
  end
end
