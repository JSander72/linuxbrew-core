class Qrencode < Formula
  desc "QR Code generation"
  homepage "https://fukuchi.org/works/qrencode/index.html.en"
  url "https://fukuchi.org/works/qrencode/qrencode-4.1.1.tar.gz"
  sha256 "da448ed4f52aba6bcb0cd48cac0dd51b8692bccc4cd127431402fca6f8171e8e"
  license "LGPL-2.1-or-later"

  livecheck do
    url "https://fukuchi.org/works/qrencode/"
    regex(/href=.*?qrencode[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "aba117089d1c60fd2fa1d36fbfa06a0929b23d5bb6a7417d6f2dafb5dcc32c5b"
    sha256 cellar: :any, big_sur:       "1b3d2022412f9d5486550fb68250aee25bb358a04e2cccc7bb85c7d65b1885b0"
    sha256 cellar: :any, catalina:      "326d2f182c7c8d9188be7adda5bd0ecb5922269f60f72ac265e404fa17fb310f"
    sha256 cellar: :any, mojave:        "a8ec712f32c4d8b09d4c098c37264ea41f0f382525c5b67e657248fdd9f1f53d"
    sha256 cellar: :any, high_sierra:   "a6d123b7f88941fe9959970d8b6ccfbc426c2ec405cfc731bc259f2b0f536171"
    sha256 cellar: :any, x86_64_linux:  "2dffd63b3e2801ac86c917399021800654b6fa37937396f9a9c4daaea25374bd" # linuxbrew-core
  end

  head do
    url "https://github.com/fukuchi/libqrencode.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libpng"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/qrencode", "123456789", "-o", "test.png"
  end
end
