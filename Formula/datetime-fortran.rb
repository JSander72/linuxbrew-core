class DatetimeFortran < Formula
  desc "Fortran time and date manipulation library"
  homepage "https://github.com/wavebitscientific/datetime-fortran"
  url "https://github.com/wavebitscientific/datetime-fortran/releases/download/v1.7.0/datetime-fortran-1.7.0.tar.gz"
  sha256 "cff4c1f53af87a9f8f31256a3e04176f887cc3e947a4540481ade4139baf0d6f"
  license "MIT"
  revision 1 unless OS.mac?

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e2986c9fde31f0bb075f4399c251599b481e2c9f5509e9ba6aa56e2fd8f2c939"
    sha256 cellar: :any_skip_relocation, big_sur:       "13b551703e1afcdcb1c4a92939afdce7447fbf96e071c984944a8bee8e833496"
    sha256 cellar: :any_skip_relocation, catalina:      "82d8b0e2a51fb7df321659ed4f5da43c24edd5aba81e5e05250508b541f2eb4b"
    sha256 cellar: :any_skip_relocation, mojave:        "ef59feabc30610c41a5ac4b2e594f1378d3edeb3b13dd7912825c48815d547e2"
    sha256 cellar: :any_skip_relocation, high_sierra:   "cf59b21c0539aa14f5e0274387669d13dae47b3e11267cdb1baed8545f2bd535"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5a33f9ccf15d85d1c524cbf2d80cb7817f042ad8d8a996f7f6505b1ab83c43b4" # linuxbrew-core
  end

  head do
    url "https://github.com/wavebitscientific/datetime-fortran.git"

    depends_on "autoconf"   => :build
    depends_on "automake"   => :build
    depends_on "pkg-config" => :build
  end

  depends_on "gcc" # for gfortran

  def install
    system "autoreconf", "-fvi" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--disable-silent-rules"
    system "make", "install"
    (pkgshare/"test").install "tests/datetime_tests.f90"
  end

  test do
    system "gfortran", "-I#{include}", pkgshare/"test/datetime_tests.f90",
                       "-L#{lib}", "-ldatetime", "-o", "test"
    system "./test"
  end
end
