class Lzo < Formula
  desc "Real-time data compression library"
  homepage "https://www.oberhumer.com/opensource/lzo/"
  url "https://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz"
  sha256 "c0f892943208266f9b6543b3ae308fab6284c5c90e627931446fb49b4221a072"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.oberhumer.com/opensource/lzo/download/"
    regex(/href=.*?lzo[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "76d0933f626d8a1645b559b1709396a2a6fd57dbd556d2f1f1848b5fddfcd327"
    sha256 cellar: :any, big_sur:       "fcd3c9f7042104ca13be96fd0ec53acdc7da1480c16140441b2e66d4e7c5eb78"
    sha256 cellar: :any, catalina:      "c8f55ba0de85273c1851136f47b89f43ba3cce9cbf0ba9f2bba7db311544a000"
    sha256 cellar: :any, mojave:        "84f4e3223c03375b0be93bd87be98f512e092621b4f6b4216e3da7210c56ddad"
    sha256 cellar: :any, high_sierra:   "2420aac02d4765ecfd5e9b4d05402f42416c438e8bbaa43dca19e03ecff2a670"
    sha256 cellar: :any, sierra:        "26969f416ec79374e074f8434d6b7eece891fcbc8bee386e9bbd6d418149bc52"
    sha256 cellar: :any, el_capitan:    "77abd933fd899707c99b88731a743d5289cc6826bd4ff854a30e088fbbc61222"
    sha256 cellar: :any, yosemite:      "0c3824de467014932ebdb3a2915a114de95036d7661c4d09df0c0191c9149e22"
    sha256 cellar: :any, x86_64_linux:  "a41fb0e7fc06aaf7614e93a880b7011ebacfe91a2aa5cb9287d37d86affbd030" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-shared"
    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <lzo/lzoconf.h>
      #include <stdio.h>

      int main()
      {
        printf("Testing LZO v%s in Homebrew.\\n",
        LZO_VERSION_STRING);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-o", "test"
    assert_match "Testing LZO v#{version} in Homebrew.", shell_output("./test")
  end
end
