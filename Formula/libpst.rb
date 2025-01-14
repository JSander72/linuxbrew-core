class Libpst < Formula
  desc "Utilities for the PST file format"
  homepage "https://www.five-ten-sg.com/libpst/"
  url "https://www.five-ten-sg.com/libpst/packages/libpst-0.6.76.tar.gz"
  sha256 "3d291beebbdb48d2b934608bc06195b641da63d2a8f5e0d386f2e9d6d05a0b42"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.five-ten-sg.com/libpst/packages/"
    regex(/href=.*?libpst[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "d7b9d9f537b1575cbd299b56e2a82f38f661aff617cc8a3a03b44cf8acb1e3c0"
    sha256 cellar: :any,                 big_sur:       "be3136353a0d0c538070a6c1261b75620abffda9d2cee435daf3debbc5fe2f8e"
    sha256 cellar: :any,                 catalina:      "d6ec30b4b9ca7d8968c5155b98c2a32dca502910c6c95ac860dc50065de89f65"
    sha256 cellar: :any,                 mojave:        "9ba873578452d668ac195f1e3b332f692f45ee5db1a6c55e68e57e8d08d3878a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "974a841c42f8279716bf807976cc169fbb954ba4d30a3da31b9b325c4b123310" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gettext"
  depends_on "libgsf"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-python
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"lspst", "-V"
  end
end
