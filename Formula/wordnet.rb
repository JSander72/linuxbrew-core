class Wordnet < Formula
  desc "Lexical database for the English language"
  homepage "https://wordnet.princeton.edu/"
  url "https://wordnetcode.princeton.edu/3.0/WordNet-3.0.tar.bz2"
  # Version 3.1 is version 3.0 with the 3.1 dictionary.
  version "3.1"
  sha256 "6c492d0c7b4a40e7674d088191d3aa11f373bb1da60762e098b8ee2dda96ef22"
  license :cannot_represent
  revision 1

  bottle do
    sha256                               arm64_big_sur: "48c70e44e65ff918d9a7c59999af788a00a29ed67419a411c789ae8e2f29684d"
    sha256                               big_sur:       "603c49d51a805975f31491b9f0faec95900cc9bde2042a3ce042c14ed4a2a808"
    sha256                               catalina:      "56264f8aa182e0fb8d64b0166e2583465b6e373b5d69c7e2247e5ec011467a91"
    sha256                               mojave:        "8fedff541aa821dbee4d0396c2137c1cdc43968e6772a69caa664ffabbc23dbe"
    sha256                               high_sierra:   "2e7eb00a5f63eec2972c927c4e566cf51121e61f95d5f04e4e29443950e3b42f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "005d800d72d21aee626e0679d7952e8062636fe8c426c6562de6688ed637eeee" # linuxbrew-core
  end

  depends_on "tcl-tk"

  resource "dict" do
    url "https://wordnetcode.princeton.edu/wn3.1.dict.tar.gz"
    sha256 "3f7d8be8ef6ecc7167d39b10d66954ec734280b5bdcd57f7d9eafe429d11c22a"
  end

  def install
    (prefix/"dict").install resource("dict")

    # Disable calling deprecated fields within the Tcl_Interp during compilation.
    # https://bugzilla.redhat.com/show_bug.cgi?id=902561
    ENV.append_to_cflags "-DUSE_INTERP_RESULT"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-tcl=#{Formula["tcl-tk"].opt_prefix}/lib",
                          "--with-tk=#{Formula["tcl-tk"].opt_prefix}/lib"
    ENV.deparallelize
    system "make", "install"
  end

  test do
    output = pipe_output("#{bin}/wn homebrew -synsn")
    assert_match "alcoholic beverage", output
  end
end
