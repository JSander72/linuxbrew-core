class Clp < Formula
  desc "Linear programming solver"
  homepage "https://github.com/coin-or/Clp"
  url "https://github.com/coin-or/Clp/archive/releases/1.17.6.tar.gz"
  sha256 "afff465b1620cfcbb7b7c17b5d331d412039650ff471c4160c7eb24ae01284c9"
  license "EPL-1.0"
  revision 1

  livecheck do
    url :stable
    regex(%r{^(?:releases/)?v?(\d+(?:\.\d+)+)$}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "f1e732d364b18f48463953078d4ee367367728be52708473a0920b2f34313364"
    sha256 cellar: :any, big_sur:       "a77023f98b927b7a449142765c542ad774e3c92939cc1a93d29126a08acc81fb"
    sha256 cellar: :any, catalina:      "b68e1b527f9bd8a10c391f49835f379e973c4ad12fb68993d72e49604e4a21bb"
    sha256 cellar: :any, mojave:        "db3e0b70a5a5435d2c01b8c25c54615288d15dd0aef1606bc6812099b7feb052"
    sha256 cellar: :any, high_sierra:   "b279c98add833139bbdd65122391805109371eae1c2e99fbd35cbf9993e45ee5"
    sha256 cellar: :any, x86_64_linux:  "f731b1d7fd458ba27a506e1e8e1aef2ab9484d632d57b89cbd02a7579ad3b451" # linuxbrew-core
  end

  depends_on "pkg-config" => [:build, :test]
  depends_on "coinutils"
  depends_on "openblas"
  depends_on "osi"

  resource "coin-or-tools-data-sample-p0033-mps" do
    url "https://raw.githubusercontent.com/coin-or-tools/Data-Sample/releases/1.2.11/p0033.mps"
    sha256 "8ccff819023237c79ef32e238a5da9348725ce9a4425d48888baf3a0b3b42628"
  end

  def install
    # Work around https://github.com/coin-or/Clp/issues/109:
    # Error 1: "mkdir: #{include}/clp/coin: File exists."
    mkdir include/"clp/coin"

    args = [
      "--datadir=#{pkgshare}",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--includedir=#{include}/clp",
      "--prefix=#{prefix}",
      "--with-blas-incdir=#{Formula["openblas"].opt_include}",
      "--with-blas-lib=-L#{Formula["openblas"].opt_lib} -lopenblas",
      "--with-lapack-incdir=#{Formula["openblas"].opt_include}",
      "--with-lapack-lib=-L#{Formula["openblas"].opt_lib} -lopenblas",
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    resource("coin-or-tools-data-sample-p0033-mps").stage testpath
    system bin/"clp", "-import", testpath/"p0033.mps", "-primals"
    (testpath/"test.cpp").write <<~EOS
      #include <ClpSimplex.hpp>
      int main() {
        ClpSimplex model;
        int status = model.readMps("#{testpath}/p0033.mps", true);
        if (status != 0) { return status; }
        status = model.primal();
        return status;
      }
    EOS
    pkg_config_flags = `pkg-config --cflags --libs clp`.chomp.split
    system ENV.cxx, "test.cpp", *pkg_config_flags
    system "./a.out"
  end
end
