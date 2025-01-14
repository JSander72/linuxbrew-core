class Dtach < Formula
  desc "Emulates the detach feature of screen"
  homepage "https://dtach.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/dtach/dtach/0.9/dtach-0.9.tar.gz"
  sha256 "32e9fd6923c553c443fab4ec9c1f95d83fa47b771e6e1dafb018c567291492f3"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e90da47e413ace287b5144813af99ee9f2bb8cac8c435189557db29aa597c681"
    sha256 cellar: :any_skip_relocation, big_sur:       "2037a41545a48ffd293c55deb33a675a6d304df1f25c46e6f9b85969e0968d78"
    sha256 cellar: :any_skip_relocation, catalina:      "67d1aed450f459a8883148d7ce9bf89cd98025232ae6ec061381297e54276e8c"
    sha256 cellar: :any_skip_relocation, mojave:        "8126575ec7b9f9a4e9ba092e8d2c706c7a162c6dd7678c8dbbdc42676aae7eb6"
    sha256 cellar: :any_skip_relocation, high_sierra:   "286aa27d4de791d50bb7c16c57682174a9fbfd73890e7f58fa2681f48dc12c75"
    sha256 cellar: :any_skip_relocation, sierra:        "f69d8585d47b722bee78bc189708d5348548a3ad68a4ff6cb91443624f4a3f0c"
    sha256 cellar: :any_skip_relocation, el_capitan:    "bf26c7f68f65ae257c878e2008683d496a8c7542b3048e057bc3d588d779e16a"
    sha256 cellar: :any_skip_relocation, yosemite:      "fe8735b33ebb6f2fd2ea1e7c3542981833e8cad8c16fb6d9fbb5ac0f2ce493b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cc943a3594ca35cd8cd8ac982fafc0a64b8f5da972b40b2d0fb1d49f4572209d" # linuxbrew-core
  end

  def install
    # Includes <config.h> instead of "config.h", so "." needs to be in the include path.
    ENV.append "CFLAGS", "-I."

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make"
    bin.install "dtach"
    man1.install gzip("dtach.1")
  end

  test do
    system bin/"dtach", "--help"
  end
end
