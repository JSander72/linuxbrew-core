class Scws < Formula
  desc "Simple Chinese Word Segmentation"
  homepage "https://github.com/hightman/scws"
  url "http://www.xunsearch.com/scws/down/scws-1.2.3.tar.bz2"
  sha256 "60d50ac3dc42cff3c0b16cb1cfee47d8cb8c8baa142a58bc62854477b81f1af5"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "ac7b0ac31fb12e9c1e4611e00dc70e5a5a4eedec4cc3d700826937eb4f67f5a6"
    sha256 cellar: :any, big_sur:       "6d87c6c7431b97511b7ce3ec42493bff7685c6ee2682d9733428a71826a8b300"
    sha256 cellar: :any, catalina:      "4dedb954c6d17b1cc42d41a978e41a897110e042bbd6099f82bdbd0ff86b7aad"
    sha256 cellar: :any, mojave:        "feb648d3c6c98b2e693086371dae419f88b56b6d58e5ede76ffa882a6f9be4b6"
    sha256 cellar: :any, high_sierra:   "94977ce56fa0c3c9d2fb21fe52067b49be65247b41d723893ac8c91f0e2dbbf3"
    sha256 cellar: :any, sierra:        "81e6665fd65aae5e35c3e0b3f9f80bdaaf8ac787dfe6fe9e8454a8cb5cbcba02"
    sha256 cellar: :any, x86_64_linux:  "169ec9115017e6dcacba1db25247360d54a4396ca8e7198c7c6a065c3d13da1e" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/scws -c utf8 -i 人之初")
    assert_match "人 之 初", output
  end
end
