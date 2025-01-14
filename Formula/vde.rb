class Vde < Formula
  desc "Ethernet compliant virtual network"
  homepage "https://vde.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/vde/vde2/2.3.2/vde2-2.3.2.tar.gz"
  sha256 "22df546a63dac88320d35d61b7833bbbcbef13529ad009c7ce3c5cb32250af93"
  license "GPL-2.0"
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/vde\d*?[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 arm64_big_sur: "d504166629275fb173304ee78b134a6c5b5eabba65c054f2fede1949204382dd"
    sha256 big_sur:       "f634d3558c44876138a229f06554ab603b31e412a03c049d96f6c3616e579729"
    sha256 catalina:      "711f5b171e033b92505178b35a324a5c21e806ed5054a92ef02f26b3a38a760e"
    sha256 mojave:        "4f880ec345fe86fdfcfc53468c7c24d160261a17ee71a289ea3357a47b71416c"
    sha256 high_sierra:   "79ee1bbcca1f873e3740db401c1f8735f2366e785b56fcf6e0e4140e9048333b"
    sha256 x86_64_linux:  "179806e2e53ea922669aef55c8f21c192958b8b4b674d778377d5830ba5869e9" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-python"
    # 2.3.1 built in parallel but 2.3.2 does not. See:
    # https://sourceforge.net/p/vde/bugs/54/
    ENV.deparallelize
    system "make", "install"
  end
end
