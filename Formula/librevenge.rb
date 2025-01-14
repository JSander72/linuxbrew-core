class Librevenge < Formula
  desc "Base library for writing document import filters"
  homepage "https://sourceforge.net/p/libwpd/wiki/librevenge/"
  url "https://dev-www.libreoffice.org/src/librevenge-0.0.4.tar.bz2"
  mirror "https://downloads.sourceforge.net/project/libwpd/librevenge/librevenge-0.0.4/librevenge-0.0.4.tar.bz2"
  sha256 "c51601cd08320b75702812c64aae0653409164da7825fd0f451ac2c5dbe77cbf"

  livecheck do
    url "https://dev-www.libreoffice.org/src/"
    regex(/href=["']?librevenge[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "12c1a58e87956b8c15090873bb46f21b6124e8728ba897f2442fc4b2167bea4f"
    sha256 cellar: :any, big_sur:       "dcd836b2e1e671b9f072e0ea4ef910b3e84f91ce5c77b36d06a405f797fe6207"
    sha256 cellar: :any, catalina:      "42b53d00d39a37a0173cf227f8a72915b8ae15c90d527ed87344800f63ba865b"
    sha256 cellar: :any, mojave:        "8621d9448ed04170c2990e1e002822a5d609310a968701684cb17204f4db643c"
    sha256 cellar: :any, high_sierra:   "807378d354736300cb44c4e5105b0fc0bff09a4fe14fcb3a0cae40c7bf167fee"
    sha256 cellar: :any, sierra:        "2f8a2a371c35b578d181d1ce8d45084a2f699bbed95cabd10f5cd75977249542"
    sha256 cellar: :any, el_capitan:    "827a37488cc92f16ba8f4d7343e7944c7faed4b8cf9d930f49d93e4104784c94"
    sha256 cellar: :any, yosemite:      "a95c4fc2b7832e226d21a209811a2f149b8fde4962d07d354e3a6cb80b7f0a01"
    sha256 cellar: :any, x86_64_linux:  "fdcd310449d3db5bf6b6f0c0acfe2669a2f1a285ddd35ff37821574a932769f3" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "boost"

  def install
    system "./configure", "--without-docs",
                          "--disable-dependency-tracking",
                          "--enable-static=no",
                          "--disable-werror",
                          "--disable-tests",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <librevenge/librevenge.h>
      int main() {
        librevenge::RVNGString str;
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-lrevenge-0.0",
                   "-I#{include}/librevenge-0.0", "-L#{lib}"
  end
end
