class Exempi < Formula
  desc "Library to parse XMP metadata"
  homepage "https://wiki.freedesktop.org/libopenraw/Exempi/"
  url "https://libopenraw.freedesktop.org/download/exempi-2.5.2.tar.bz2"
  sha256 "52f54314aefd45945d47a6ecf4bd21f362e6467fa5d0538b0d45a06bc6eaaed5"

  livecheck do
    url "https://libopenraw.freedesktop.org/exempi/"
    regex(/href=.*?exempi[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "9993c63e20e0f25bec9217f10830945e93554caeb9ed96530b31386205f3b963"
    sha256 cellar: :any, big_sur:       "3dca3e311a819ad927266feecc2a0fa06a6baf196290655b5531ec02ea97dddd"
    sha256 cellar: :any, catalina:      "3ef58fd5cbd177ac785cfab9b58f813ce24320a507243d9d7b6c940fd463564f"
    sha256 cellar: :any, mojave:        "189bb3c57e78845c33678353cb877ad7cdedd665087c0a4525397f32088abc39"
    sha256 cellar: :any, high_sierra:   "0843f9bc589fd3c9ed0f5dfd724ba60eea4832410a0b6ff831bdb22c6563eafd"
    sha256 cellar: :any, x86_64_linux:  "178e85b9647be2f5a484c03075c98982a0a3695fab4486f0d1f08750cd406c8c" # linuxbrew-core
  end

  depends_on "boost"

  uses_from_macos "expat"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-boost=#{HOMEBREW_PREFIX}"
    system "make", "install"
  end
end
