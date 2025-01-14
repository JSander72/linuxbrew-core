class AutoconfAT213 < Formula
  desc "Automatic configure script builder"
  homepage "https://www.gnu.org/software/autoconf/"
  url "https://ftp.gnu.org/gnu/autoconf/autoconf-2.13.tar.gz"
  mirror "https://ftpmirror.gnu.org/autoconf/autoconf-2.13.tar.gz"
  sha256 "f0611136bee505811e9ca11ca7ac188ef5323a8e2ef19cffd3edb3cf08fd791e"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "075de1fe7d7cdf38d3ca84a4436a8f9839adc333e3eb42ccc21c15d77cf01fb8"
    sha256 cellar: :any_skip_relocation, big_sur:       "5d538d7301ae68a526aca1848ed4bab6fed48ee6b9375766b26d38fa2825a1c0"
    sha256 cellar: :any_skip_relocation, catalina:      "d3b4d6e06ae6749fc60fa437f1f5c2ae85a91f6979ca897e08b854f920c222a0"
    sha256 cellar: :any_skip_relocation, mojave:        "5257ef101823cbf8d20693e27bf4505aec149c7d588459fedc2791a7906eb444"
    sha256 cellar: :any_skip_relocation, high_sierra:   "5257ef101823cbf8d20693e27bf4505aec149c7d588459fedc2791a7906eb444"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c02bb36ddc516ad196527acf6a597198b1dd938482230542d55bddff989f6625" # linuxbrew-core
  end

  uses_from_macos "m4"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--program-suffix=213",
                          "--prefix=#{prefix}",
                          "--infodir=#{pkgshare}/info",
                          "--datadir=#{pkgshare}"
    system "make", "install"
  end

  test do
    assert_match "Usage: autoconf", shell_output("#{bin}/autoconf213 --help 2>&1")
  end
end
