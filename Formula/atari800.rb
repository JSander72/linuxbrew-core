class Atari800 < Formula
  desc "Atari 8-bit machine emulator"
  homepage "https://atari800.github.io/"
  url "https://github.com/atari800/atari800/releases/download/ATARI800_4_2_0/atari800-4.2.0-src.tgz"
  sha256 "55cb5568229c415f1782130afd11df88c03bb6d81fa4aa60a4ac8a2f151f1359"
  license "GPL-2.0"

  livecheck do
    url :stable
    strategy :github_latest
    regex(%r{href=.*?/tag/ATARI800[._-]v?(\d+(?:[._]\d+)+)["' >]}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "48470ef79c6f3917d2af5cd4fbf76a6dd2b3ff8f88304765c10d81fa2ef5d647"
    sha256 cellar: :any, big_sur:       "b2ea1619d6fba699f3936cfb82c28b6d73aafc9d41ad39ee51e9bd49a5840ab2"
    sha256 cellar: :any, catalina:      "5bc2d96418e21a76809abfa2513f630cb207848b0894f27cda34b2f55bace81c"
    sha256 cellar: :any, mojave:        "f5508c8a0021a0fcbd1e35d7a4313d8c9ba52ab937d0fde59ccc5f81e3c49ac0"
    sha256 cellar: :any, high_sierra:   "497ce17afc99e76180b94b76b08c1aca973eab554ee3ccecfd14818c71e97035"
    sha256 cellar: :any, x86_64_linux:  "cf4acbde8ded93005a2795a12b71ddb01f4f948d71ecaa7da1f2524e137e0085" # linuxbrew-core
  end

  depends_on "libpng"
  depends_on "sdl"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-sdltest",
                          "--disable-riodevice"
    system "make", "install"
  end

  test do
    assert_equal "Atari 800 Emulator, Version #{version}",
                 shell_output("#{bin}/atari800 -v", 3).strip
  end
end
