class Libmaxminddb < Formula
  desc "C library for the MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/libmaxminddb/releases/download/1.6.0/libmaxminddb-1.6.0.tar.gz"
  sha256 "7620ac187c591ce21bcd7bf352376a3c56a933e684558a1f6bef4bd4f3f98267"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "ac6991a335a409db72750dfc3756d09705c3e5e308e6445df213a1584b5e4cd4"
    sha256 cellar: :any,                 big_sur:       "44c4fa58c0113cb4e8784ac6fe0dfc7d2fc21d163c2c939171d83c45f5f70c8c"
    sha256 cellar: :any,                 catalina:      "ba231cfafcbd5b10b1ba0b38d2b53d006449b7799db27f795aad7358f1cbf2a7"
    sha256 cellar: :any,                 mojave:        "2320b83ae954d4a25180bf6b3d20ed7e3eb174b4ecb83ab12fd94f4ebeecb228"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9da1d2478773fb5875ca9f17a51e838297065650a8894a1680f7de96f764f859" # linuxbrew-core
  end

  head do
    url "https://github.com/maxmind/libmaxminddb.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "./bootstrap" if build.head?

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
    (share/"examples").install buildpath/"t/maxmind-db/test-data/GeoIP2-City-Test.mmdb"
  end

  test do
    system "#{bin}/mmdblookup", "-f", "#{share}/examples/GeoIP2-City-Test.mmdb",
                                "-i", "175.16.199.0"
  end
end
