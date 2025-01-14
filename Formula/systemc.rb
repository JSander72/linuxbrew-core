class Systemc < Formula
  desc "Core SystemC language and examples"
  homepage "https://accellera.org/"
  url "https://www.accellera.org/images/downloads/standards/systemc/systemc-2.3.2.tar.gz"
  sha256 "a28eeee00189f0e39f51461dcd7dbed7fb38e4e07dbd9e723473000ce6ef73c5"
  license "Apache-2.0"

  livecheck do
    url "https://www.accellera.org/downloads/standards/systemc"
    regex(/href=.*?systemc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, big_sur:      "9deac1357ecb0652caa491858a81658cc0ff86317d50d4d511aced6dc62373b0"
    sha256 cellar: :any, catalina:     "514a49408461d311e27def414b559298e514df9be6461408e691aa2ba44ff0d5"
    sha256 cellar: :any, mojave:       "ed266b79f596258da162637530a1830516ceee6fb4874add5eaa9a84b175cda4"
    sha256 cellar: :any, high_sierra:  "7d189564e4277390f8fa0c2e067f17dc31148e33af65c0998b6242405f761a18"
    sha256 cellar: :any, sierra:       "257ab0155a4e4f5d6dea22696f265d1a523efa24627487a5fad4ad70d43e7fd0"
    sha256 cellar: :any, el_capitan:   "8dbfcaef7cbca7116bacb300288520ed357768c148a612de2f9a3483266add87"
    sha256 cellar: :any, x86_64_linux: "b7625cf642ee677ba097b904d5aa98c372caf53e1c31f95e558abd7aed8d8642" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-arch-suffix=",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include "systemc.h"

      int sc_main(int argc, char *argv[]) {
        return 0;
      }
    EOS
    system ENV.cxx, "-L#{lib}", "-lsystemc", "test.cpp"
    system "./a.out"
  end
end
