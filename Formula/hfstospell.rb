class Hfstospell < Formula
  desc "Helsinki Finite-State Technology ospell"
  homepage "https://hfst.github.io/"
  url "https://github.com/hfst/hfst-ospell/releases/download/v0.5.2/hfst-ospell-0.5.2.tar.bz2"
  sha256 "ab9ccf3c2165c0efd8dd514e0bf9116e86a8a079d712c0ed6c2fabf0052e9aa4"
  license "Apache-2.0"
  revision 2

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "1a5437ebb7e8abeae096734d53edbbc8cf154f6635f8e15ac3a1cfa038782e85"
    sha256 cellar: :any,                 big_sur:       "6fb2851153c12aa38ed01a7335781df78be3490380e6713b2a9c642f88e737d0"
    sha256 cellar: :any,                 catalina:      "0651d2057fcf3c0242bcd277b0ddafb247c0f00fc78d2652e9eae9c82776f923"
    sha256 cellar: :any,                 mojave:        "25a4f7bfe15fae7efd0ce6cf1ccedb150571935de5e0266cbf7fa472290bbf6d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ea2697fe154ae351227cb6a249248657bc94239acaf19fafffb8cd99b36eb5d2" # linuxbrew-core
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "icu4c"
  depends_on "libarchive"

  def install
    ENV.cxx11
    system "autoreconf", "-fiv"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--without-libxmlpp",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/hfst-ospell", "--version"
  end
end
