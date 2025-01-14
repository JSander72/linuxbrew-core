class Dropbear < Formula
  desc "Small SSH server/client for POSIX-based system"
  homepage "https://matt.ucc.asn.au/dropbear/dropbear.html"
  url "https://matt.ucc.asn.au/dropbear/releases/dropbear-2020.81.tar.bz2"
  sha256 "48235d10b37775dbda59341ac0c4b239b82ad6318c31568b985730c788aac53b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c8681650c799bb023d972a9cc0dc9c07fd0ce37fc6f801a4b990af151f364b3b"
    sha256 cellar: :any_skip_relocation, big_sur:       "ba4a09e7636d2629bdc11bfc5a99f9cab29eb351fb52a05c82533c76c29c87c8"
    sha256 cellar: :any_skip_relocation, catalina:      "9659a7bdf1475748311e5a1e768ffb01d9020ddf7e19c7f8412bb62dc883d817"
    sha256 cellar: :any_skip_relocation, mojave:        "55f1c51b6d253bcf03c6957139fae7e3b4f4cdcbdc90416ff9bd63f98d21a26d"
    sha256 cellar: :any_skip_relocation, high_sierra:   "59f3c740122b0f90b294d8b6e465cb9685b76617056cf9ae6554c221c681ed1c"
  end

  head do
    url "https://github.com/mkj/dropbear.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  on_linux do
    depends_on "linux-pam"
  end

  def install
    ENV.deparallelize

    if build.head?
      system "autoconf"
      system "autoheader"
    end
    system "./configure", "--prefix=#{prefix}",
                          "--enable-pam",
                          "--enable-zlib",
                          "--enable-bundled-libtom",
                          "--sysconfdir=#{etc}/dropbear"
    system "make"
    system "make", "install"
  end

  test do
    testfile = testpath/"testec521"
    system "#{bin}/dbclient", "-h"
    system "#{bin}/dropbearkey", "-t", "ecdsa", "-f", testfile, "-s", "521"
    assert_predicate testfile, :exist?
  end
end
