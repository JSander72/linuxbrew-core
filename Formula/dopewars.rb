class Dopewars < Formula
  desc 'Free rewrite of a game originally based on "Drug Wars"'
  homepage "https://dopewars.sourceforge.io"
  url "https://downloads.sourceforge.net/project/dopewars/dopewars/1.6.1/dopewars-1.6.1.tar.gz"
  sha256 "83127903a61d81cda251a022f9df150d11e27bdd040e858c09c57927cc0edea6"
  license "GPL-2.0-or-later"

  bottle do
    sha256 arm64_big_sur: "490e166c6e7a12f93f51271b80aca3d3e6471089e51f77ba30db1ebce1861dcd"
    sha256 big_sur:       "390ce7a719041ebf745d790ea872db927cb587cfc91ddab183472fe2ceecec43"
    sha256 catalina:      "85d6516b31e2bd45f92d2e2c18f773ec2b2990b25da82155454274e8c65eaa3d"
    sha256 mojave:        "abe0910c15903b12be25d3b00f4544f39d10b894c5b773468b7b52e3c403893b"
    sha256 x86_64_linux:  "97c20d070dace0f2718d7d3bd7e7e36624b9cdbfea8a553ce4bce26cffcf261d" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "glib"

  uses_from_macos "curl"

  def install
    inreplace "src/Makefile.in", "$(dopewars_DEPENDENCIES)", ""
    inreplace "auxbuild/ltmain.sh", "need_relink=yes", "need_relink=no"
    inreplace "src/plugins/Makefile.in", "LIBADD =", "LIBADD = -module -avoid-version"
    system "./configure", "--disable-gui-client",
                          "--disable-gui-server",
                          "--enable-plugins",
                          "--enable-networking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--disable-debug",
                          "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/dopewars", "-v"
  end
end
