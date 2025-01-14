class Reprepro < Formula
  desc "Debian package repository manager"
  homepage "https://salsa.debian.org/brlink/reprepro"
  url "https://deb.debian.org/debian/pool/main/r/reprepro/reprepro_5.3.0.orig.tar.gz"
  sha256 "5a5404114b43a2d4ca1f8960228b1db32c41fb55de1996f62bc1b36001f3fab4"
  revision OS.mac? ? 3 : 4

  bottle do
    sha256                               arm64_big_sur: "693fdd1c5fca04420ddc514398668a446fdc70a0d9ba9b3c1ee4a6fba0d9cb9e"
    sha256 cellar: :any,                 big_sur:       "0a1ef02efd94289dea92547ed6735422eaf66fd92a02d69472af8ae69bfdc056"
    sha256 cellar: :any,                 catalina:      "92ecf42593483a44d3a39af6e7e3be0a4336f499ce19dcdbaac7294ef7f7b4b5"
    sha256 cellar: :any,                 mojave:        "5478d8a1d013eaf8ce47c4c5b2e0afab9b2dbd76b4f4d3dbe09e6f0efa0683b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e16d602529c35f7ce6d8242e2a9e0086585926ddfcee058c1e938233204a1a57" # linuxbrew-core
  end

  depends_on "berkeley-db@4"
  depends_on "gpgme"
  depends_on "libarchive"
  depends_on "xz"

  on_macos do
    depends_on "gcc"
  end

  fails_with :clang do
    cause "No support for GNU C nested functions"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-gpgme=#{Formula["gpgme"].opt_lib}",
                          "--with-libarchive=#{Formula["libarchive"].opt_lib}",
                          "--with-libbz2=yes",
                          "--with-liblzma=#{Formula["xz"].opt_lib}"
    system "make", "install"
  end

  test do
    (testpath/"conf"/"distributions").write <<~EOF
      Codename: test_codename
      Architectures: source
      Components: main
    EOF
    system bin/"reprepro", "-b", testpath, "list", "test_codename"
  end
end
