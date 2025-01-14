class Libyubikey < Formula
  desc "C library for manipulating Yubico one-time passwords"
  homepage "https://yubico.github.io/yubico-c/"
  url "https://developers.yubico.com/yubico-c/Releases/libyubikey-1.13.tar.gz"
  sha256 "04edd0eb09cb665a05d808c58e1985f25bb7c5254d2849f36a0658ffc51c3401"
  license "BSD-2-Clause"

  livecheck do
    url "https://developers.yubico.com/yubico-c/Releases/"
    regex(/href=.*?libyubikey[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "281fc4490bcdf4c4b19c5aa08a10a996e8fb10c9e1385ba95abd973186e18932"
    sha256 cellar: :any, big_sur:       "d8294cc5022aa96ca4d2073756da801daef11a07e3464656af749008b84cde6d"
    sha256 cellar: :any, catalina:      "b6fccb68ae85837533ea4680063cc64f207f2d6926c4eafaf23e81f0b790fc55"
    sha256 cellar: :any, mojave:        "f5f99ad5056fe1d8bfa69a389983ac9ae0f5e65c60d984de4fb9591b6b19daba"
    sha256 cellar: :any, high_sierra:   "8440f766e153b537a092f55a07990c0fd28e0b244407bf6824d21fedb3d97f32"
    sha256 cellar: :any, sierra:        "23f550d2f6e2cd6310756e3625c17868e206c90029e241fbc915a408f4761263"
    sha256 cellar: :any, el_capitan:    "2b1fbc1860932dd4a4c2b09928d838bc3646ff0b2a97bc5c538981befdc21760"
    sha256 cellar: :any, yosemite:      "7f5c7a55b9e5bf373f01f8f02a983d45ae11d801acc8110cd8f5e13edf0e2973"
    sha256 cellar: :any, x86_64_linux:  "47b0325d71e03da76b69b3eb8449b7ed0cb10cd7cfcff99adb0f3c70975551b3" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
