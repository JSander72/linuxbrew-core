class ArpSk < Formula
  desc "ARP traffic generation tool"
  homepage "https://web.archive.org/web/20180223202629/sid.rstack.org/arp-sk/"
  url "https://web.archive.org/web/20180223202629/sid.rstack.org/arp-sk/files/arp-sk-0.0.16.tgz"
  mirror "https://pkg.freebsd.org/ports-distfiles/arp-sk-0.0.16.tgz"
  sha256 "6e1c98ff5396dd2d1c95a0d8f08f85e51cf05b1ed85ea7b5bcf73c4ca5d301dd"
  revision 1

  bottle do
    sha256 cellar: :any, arm64_big_sur: "e9a3123cc035debcdac3582b5aa868cf8ab2f64d10c2ddac6e41df4df0121d52"
    sha256 cellar: :any, big_sur:       "206b69b4456fabe2614dbf5c5ab2886530d2b238f18adb28545a9758fc9a4561"
    sha256 cellar: :any, catalina:      "bc28c6d58a3838fac59ab625ab26a917b3b0282ac54a8f37a95034efd0740007"
    sha256 cellar: :any, mojave:        "cbe02395698a24f9f835b7cba4128a308a15beefda6ad7e79cfd38d73823cdc2"
    sha256 cellar: :any, high_sierra:   "67666cd80446c78b49deac3b8f2589ccbd140f32b739b662556a6dc7bda7b453"
    sha256 cellar: :any, x86_64_linux:  "1c9215134a1f069e1c1de831073efa158a7cc2194f6a7680b71862f6755f3afc" # linuxbrew-core
  end

  depends_on "libnet"

  def install
    # libnet 1.2 compatibility - it is API compatible with 1.1.
    # arp-sk's last update was in 2004.
    inreplace "configure", "1.1.", "1.2"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--with-libnet=#{Formula["libnet"].opt_prefix}"
    system "make", "install"
  end

  test do
    assert_match "arp-sk version #{version}", shell_output("#{sbin}/arp-sk -V")
  end
end
