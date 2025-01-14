class GnustepMake < Formula
  desc "Basic GNUstep Makefiles"
  homepage "http://gnustep.org"
  url "http://ftpmain.gnustep.org/pub/gnustep/core/gnustep-make-2.9.0.tar.gz"
  sha256 "a0b066c11257879c7c85311dea69c67f6dc741ef339db6514f85b64992c40d2a"
  license "GPL-3.0-or-later"

  livecheck do
    url "http://ftpmain.gnustep.org/pub/gnustep/core/"
    regex(/href=.*?gnustep-make[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f16315c14cfbdab197ea1562749d533ebbf19435b848a8173ae7c3ed08502968"
    sha256 cellar: :any_skip_relocation, big_sur:       "b0a74dcdffdd9331348c0215f53967dcd4ecd9b2f8c2fdbdff32f27c288136af"
    sha256 cellar: :any_skip_relocation, catalina:      "3fb00ffefe165c26880819f9d670468d5c874a055792a0a2b25ca47e4dcad43a"
    sha256 cellar: :any_skip_relocation, mojave:        "449a586b8998cc6e5e45ffde3f518c5352cf5e31bd126b102d1597d4b76d6985"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6991c545807aca6b3db9cdfb255ce1285c65409db4b58f853eea4d24780f7941" # linuxbrew-core
  end

  def install
    system "./configure", *std_configure_args,
                          "--with-config-file=#{prefix}/etc/GNUstep.conf",
                          "--enable-native-objc-exceptions"
    system "make", "install", "tooldir=#{libexec}"
  end

  test do
    assert_match shell_output("#{libexec}/gnustep-config --variable=CC").chomp, ENV.cc
  end
end
