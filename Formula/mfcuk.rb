class Mfcuk < Formula
  desc "MiFare Classic Universal toolKit"
  homepage "https://github.com/nfc-tools/mfcuk"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mfcuk/mfcuk-0.3.8.tar.gz"
  sha256 "977595765b4b46e4f47817e9500703aaf5c1bcad39cb02661f862f9d83f13a55"
  license "GPL-2.0"
  revision 1

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "f37625d6d5f84b70a6e85359da444790d64a56f898c8051c41f314ad061cbc42"
    sha256 cellar: :any,                 big_sur:       "0da7f4ed6a6b71a7960274fc7f020510d289269d6a3ed1e8f84f884a2619a684"
    sha256 cellar: :any,                 catalina:      "c9191edf0484422fa432827e017d05d4854cde1fd8194a3735eec0e060884652"
    sha256 cellar: :any,                 mojave:        "2540f3232f4220dac3cf296c43fea2f2582c71ab18037e9d0c047c4f1df39f71"
    sha256 cellar: :any,                 high_sierra:   "f624f03ed0674915332412b50d0013a9495aece4b1ef773767024d11b8fd0d8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fbe6f2d40f1d9869ce2cf35ba55fce1aee8200ed0fb609a06fb219daa0ead0ef" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libnfc"
  depends_on "libusb"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"mfcuk", "-h"
  end
end
