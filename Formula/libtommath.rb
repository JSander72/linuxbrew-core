class Libtommath < Formula
  desc "C library for number theoretic multiple-precision integers"
  homepage "https://www.libtom.net/LibTomMath/"
  url "https://github.com/libtom/libtommath/releases/download/v1.2.0/ltm-1.2.0.tar.xz"
  sha256 "b7c75eecf680219484055fcedd686064409254ae44bc31a96c5032843c0e18b1"
  license "Unlicense"
  revision 3
  head "https://github.com/libtom/libtommath.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "b91f82bc2fd4b0e36615b3ce67833e41a5bfde5fc35d0f29b1b20c49bbc31d89"
    sha256 cellar: :any,                 big_sur:       "0f2e569f0625e7f52974b6cc69cdc51ee83dc8c302af03863fb3926fdc9c768f"
    sha256 cellar: :any,                 catalina:      "35421851dc5c86313eda9b351b5401196d757e4e8de90fd410029862704a5f8d"
    sha256 cellar: :any,                 mojave:        "631d118cba4e115604723dea978a4c439fd150480f7526bbcd2feec70300da83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d802d4a97d466abbf0bb159885ce6dc4cf2768f67af89f0fa4e9fd0cf1d9e4d8" # linuxbrew-core
  end

  depends_on "libtool" => :build

  # Fixes mp_set_double being missing on macOS.
  # This is needed by some dependents in homebrew-core.
  # NOTE: This patch has been merged upstream but we take a backport
  # from a fork due to file name differences between 1.2.0 and master.
  # Remove with the next version.
  patch do
    url "https://github.com/MoarVM/libtommath/commit/db0d387b808d557bd408a6a253c5bf3a688ef274.patch?full_index=1"
    sha256 "e5eef1762dd3e92125e36034afa72552d77f066eaa19a0fd03cd4f1a656f9ab0"
  end

  def install
    ENV["PREFIX"] = prefix

    system "make", "-f", "makefile.shared", "install"
    system "make", "test"
    pkgshare.install "test"
  end

  test do
    system pkgshare/"test"
  end
end
