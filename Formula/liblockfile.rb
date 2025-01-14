class Liblockfile < Formula
  desc "Library providing functions to lock standard mailboxes"
  homepage "https://tracker.debian.org/pkg/liblockfile"
  url "https://deb.debian.org/debian/pool/main/libl/liblockfile/liblockfile_1.17.orig.tar.gz"
  sha256 "6e937f3650afab4aac198f348b89b1ca42edceb17fb6bb0918f642143ccfd15e"
  license "LGPL-2.0-or-later"

  bottle do
    sha256 arm64_big_sur: "41a9d79f95f938532b4320a29c5f5bf3d7229a6df3f06413112d903e23589078"
    sha256 big_sur:       "d13b1ce9f35885e1b05c9bd436e8edd0fc1b0dc7475219773655cb69bafcfbb3"
    sha256 catalina:      "a923faddb180ea86f1038424613c3191bf5212fc44e25548284f5a0525e1b5e9"
    sha256 mojave:        "143542d504f3f37df987e6f2c4291c2966cdb9ac15a6fd581155a4079758575e"
    sha256 x86_64_linux:  "427da93f6d23200bf069058b18551b78701d5891a9474aa26b3fec9005e11bbe" # linuxbrew-core
  end

  def install
    # brew runs without root privileges (and the group is named "wheel" anyway)
    inreplace "Makefile.in", " -g root ", " "

    system "./configure", "--disable-dependency-tracking",
                          "--disable-debug",
                          "--with-mailgroup=staff",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--mandir=#{man}"
    bin.mkpath
    lib.mkpath
    include.mkpath
    man1.mkpath
    man3.mkpath
    system "make"
    system "make", "install"
  end

  test do
    system bin/"dotlockfile", "-l", "locked"
    assert_predicate testpath/"locked", :exist?
    system bin/"dotlockfile", "-u", "locked"
    refute_predicate testpath/"locked", :exist?
  end
end
