class Foma < Formula
  desc "Finite-state compiler and C library"
  homepage "https://code.google.com/p/foma/"
  url "https://bitbucket.org/mhulden/foma/downloads/foma-0.9.18.tar.gz"
  sha256 "cb380f43e86fc7b3d4e43186db3e7cff8f2417e18ea69cc991e466a3907d8cbd"
  license "GPL-2.0-only"
  revision 1 unless OS.mac?

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "8cac09b69356887a31f4d2314b9eb7a193ad21858b0cc43ade7d48a485e4b55d"
    sha256 cellar: :any, big_sur:       "cdf3b3105f0207ddea3f5b0ba458b650cab22b1ac3db85896631ec5304cc5bf1"
    sha256 cellar: :any, catalina:      "dc0a238f67280d9e15e50bc7064669f1715170c9a59d608537ed195801db0c9e"
    sha256 cellar: :any, mojave:        "a3b11300d427959a0ca8aa908d6c43369a8c17889a63f56d7772c6c4fdaeee04"
    sha256 cellar: :any, high_sierra:   "d223eaa3a2f821d24b5f3b5486494a1a029f96e1640d4fe6f3633e6ad53e14a9"
    sha256 cellar: :any, x86_64_linux:  "1f30a342aeb7b5e51d1238a36ee9021f3264ac502b2544a2e1a5b259c1cbc68f" # linuxbrew-core
  end

  uses_from_macos "zlib"

  on_linux do
    depends_on "readline"
  end

  conflicts_with "freeling", because: "freeling ships its own copy of foma"

  def install
    system "make"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    # Source: https://code.google.com/p/foma/wiki/ExampleScripts
    (testpath/"toysyllabify.script").write <<~EOS
      define V [a|e|i|o|u];
      define Gli [w|y];
      define Liq [r|l];
      define Nas [m|n];
      define Obs [p|t|k|b|d|g|f|v|s|z];

      define Onset (Obs) (Nas) (Liq) (Gli); # Each element is optional.
      define Coda  Onset.r;                 # Is mirror image of onset.

      define Syllable Onset V Coda;
      regex Syllable @> ... "." || _ Syllable;

      apply down> abrakadabra
    EOS

    system "#{bin}/foma", "-f", "toysyllabify.script"
  end
end
