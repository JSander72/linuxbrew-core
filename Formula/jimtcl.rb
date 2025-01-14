class Jimtcl < Formula
  desc "Small footprint implementation of Tcl"
  homepage "http://jim.tcl.tk/index.html"
  url "https://github.com/msteveb/jimtcl/archive/0.80.tar.gz"
  sha256 "9e79a960de925552eeb4df51121f0ea017e34409568117b1ac461f4c3071289e"
  license "BSD-2-Clause"

  bottle do
    sha256 arm64_big_sur: "194b77f5eaea45ef59c1c4f7c458a6cb2840867aab53fda18201a9034beab3d9"
    sha256 big_sur:       "f2cd0d86c21972a004859681810edd946bff3e87a5c7582b2222ad29b93a562f"
    sha256 catalina:      "fc4750e0deaf8025402e6a2ed78bd28bcddb98f39012bf3d0c9c8413480505c7"
    sha256 mojave:        "d9ae5a5d397bf13c6c9c6f355a007454ef05d00e82938d75cdcc549fd7538c0d"
    sha256 high_sierra:   "4ba0d399f6622e3ce37433c43f314a5cb8546d0a08f2700cb45d67a04d6f1706"
    sha256 x86_64_linux:  "44d61dcc99799b14347c3af80861bdb6da6729eb21282b0a41e1ba7160d91fef" # linuxbrew-core
  end

  depends_on "openssl@1.1"
  depends_on "readline"

  uses_from_macos "sqlite"
  uses_from_macos "zlib"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--full",
                          "--with-ext=readline,rlprompt,sqlite3",
                          "--shared",
                          "--docdir=#{doc}",
                          "--maintainer",
                          "--math",
                          "--ssl",
                          "--utf8"
    system "make"
    system "make", "install"
    pkgshare.install Dir["examples*"]
  end

  test do
    (testpath/"test.tcl").write "puts {Hello world}"
    assert_match "Hello world", shell_output("#{bin}/jimsh test.tcl")
  end
end
