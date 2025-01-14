class SimpleObfs < Formula
  desc "Simple obfusacting plugin of shadowsocks-libev"
  homepage "https://github.com/shadowsocks/simple-obfs"
  url "https://github.com/shadowsocks/simple-obfs.git",
      tag:      "v0.0.5",
      revision: "a9c43588e4cb038e6ac02f050e4cab81f8228dff"
  license "GPL-3.0"
  revision 1

  bottle do
    sha256 cellar: :any, arm64_big_sur: "a79c2a9ba2a6473853a0907355290287b5f9faf4dcd808e1819608f0498b236f"
    sha256 cellar: :any, big_sur:       "6fc8b9d2aef7c813449e5298e1fcbcb7e5f1ba6da4c34b9e4b3c3a5e0005110e"
    sha256 cellar: :any, catalina:      "64ac7bb71b3dd0a0d087d7f981c53516abfb294f709d84cb969b192456310c51"
    sha256 cellar: :any, mojave:        "7d00695065a2e780f6a93d98d3d2a96ebe4c02fe48e52e30cea4fefe353100e8"
    sha256 cellar: :any, high_sierra:   "08024887dc9fba3f56425181dd34dba1ecf185dad688b85d20a7b70ec07afbae"
    sha256 cellar: :any, sierra:        "831de4a180d61c801397ead63a0130d8d2eb102afb526ef81bcecb2f9d1d029b"
    sha256 cellar: :any, el_capitan:    "eccfcd8d4016297999d730fd185624b42e903f7dfac43bd6227c337c2b3aafea"
    sha256 cellar: :any, x86_64_linux:  "1e6100821cd18c5579eb2f55d2ca71d0ee0dda8bf84e062f02387e66036f0c45" # linuxbrew-core
  end

  depends_on "asciidoc" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "xmlto" => :build
  depends_on "libev"

  def install
    ENV["XML_CATALOG_FILES"] = etc/"xml/catalog"
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--enable-applecc"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "simple-obfs", shell_output("#{bin}/obfs-local -h 2>&1")
  end
end
