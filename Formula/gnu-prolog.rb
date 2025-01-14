class GnuProlog < Formula
  desc "Prolog compiler with constraint solving"
  homepage "http://www.gprolog.org/"
  url "http://www.gprolog.org/gprolog-1.5.0.tar.gz"
  sha256 "670642b43c0faa27ebd68961efb17ebe707688f91b6809566ddd606139512c01"
  license any_of: ["LGPL-3.0-or-later", "GPL-2.0-or-later"]

  livecheck do
    url :homepage
    regex(/href=.*?gprolog[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "d0a8099131295fb00e49b1921a544e5cf0564593f52a35cccdae8fe239785c2c"
    sha256 cellar: :any_skip_relocation, catalina:     "7d5b67ea483e7b80e2a2d1ff30874d53afe0d5f416ef6d7e4480beaa3be6153a"
    sha256 cellar: :any_skip_relocation, mojave:       "b89f575f9b32a43180b7ad527e2ac9f71b9de4440285cccb1a326752a12ef7c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "994e31ce3165e306a88f45ee3cc6bf7c918ba534d925891ac2ab4af86e00b8ff" # linuxbrew-core
  end

  def install
    cd "src" do
      system "./configure", "--prefix=#{prefix}", "--with-doc-dir=#{doc}"
      ENV.deparallelize
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.pl").write <<~EOS
      :- initialization(main).
      main :- write('Hello World!'), nl, halt.
    EOS
    system "#{bin}/gplc", "test.pl"
    assert_match "Hello World!", shell_output("./test")
  end
end
