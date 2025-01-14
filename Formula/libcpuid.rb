class Libcpuid < Formula
  desc "Small C library for x86 CPU detection and feature extraction"
  homepage "https://github.com/anrieff/libcpuid"
  url "https://github.com/anrieff/libcpuid/archive/v0.5.1.tar.gz"
  sha256 "36d62842ef43c749c0ba82237b10ede05b298d79a0e39ef5fd1115ba1ff8e126"
  license "BSD-2-Clause"
  head "https://github.com/anrieff/libcpuid.git"

  bottle do
    sha256 cellar: :any,                 big_sur:      "f7252b191ada11eee6bb25649cba4fda28be44c91ebcfd936e3508d3573bf4f1"
    sha256 cellar: :any,                 catalina:     "e954e21a3bb2ab10c1eb831af1626ccf9cbbe69e123a4da6d69975d59cfca867"
    sha256 cellar: :any,                 mojave:       "9cb4e35df56ce25adcfc4c0a03f1a377aac54ec7e217bc9bb583df41eebcc8c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a6caf9f4f13f5d7423e6ffba9039d5077b0b8917122b8e8af5f44432e9c87cb8" # linuxbrew-core
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "-ivf"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"cpuid_tool"
    assert_predicate testpath/"raw.txt", :exist?
    assert_predicate testpath/"report.txt", :exist?
    assert_match "CPUID is present", File.read(testpath/"report.txt")
  end
end
