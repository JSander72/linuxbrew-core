class Omniorb < Formula
  desc "IOR and naming service utilities for omniORB"
  homepage "https://omniorb.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/omniorb/omniORB/omniORB-4.2.4/omniORB-4.2.4.tar.bz2"
  sha256 "28c01cd0df76c1e81524ca369dc9e6e75f57dc70f30688c99c67926e4bdc7a6f"
  license "GPL-2.0"
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/omniORB[._-]v?(\d+(?:\.\d+)+(?:-\d+)?)\.t}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "af99975268bf9395f8aa6b00521f5dde8e41434a2bc19ee45aa9abba372bad75"
    sha256 cellar: :any,                 big_sur:       "625e7bb2ca70ac3a1e52d3cc8ef9b1614b498eb24b00cdc78736dcea7c40c9cf"
    sha256 cellar: :any,                 catalina:      "e25345b167440b0a34a7399a267b487d0e8ffb24ccd5f9c2cbbf874b8a38e729"
    sha256 cellar: :any,                 mojave:        "5c8d7b0adeca7c70af83d5b13acc4629e8329104562deaea9f329bf7345ad272"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5596a81c5da5da965cdc999ff349604fc650ec9336cd2c52aa1aae1c829f425" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "python@3.9"

  resource "bindings" do
    url "https://downloads.sourceforge.net/project/omniorb/omniORBpy/omniORBpy-4.2.4/omniORBpy-4.2.4.tar.bz2"
    sha256 "dae8d867559cc934002b756bc01ad7fabbc63f19c2d52f755369989a7a1d27b6"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    resource("bindings").stage do
      system "./configure", "--prefix=#{prefix}", "PYTHON=python3"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/omniidl", "-h"
  end
end
