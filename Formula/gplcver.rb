class Gplcver < Formula
  desc "Pragmatic C Software GPL Cver 2001"
  homepage "https://gplcver.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/gplcver/gplcver/2.12a/gplcver-2.12a.src.tar.bz2"
  sha256 "f7d94677677f10c2d1e366eda2d01a652ef5f30d167660905c100f52f1a46e75"

  # This regex intentionally matches seemingly unstable versions, as the only
  # available version at the time of writing was `2.12a`.
  livecheck do
    url :stable
    regex(%r{url=.*?/gplcver[._-]v?(\d+(?:\.\d+)+[a-z]?)\.src\.}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fcf72ee125083159c6ab19cf20f0b5e1aeebcba61210776afe558f7eefe7e3ae"
    sha256 cellar: :any_skip_relocation, big_sur:       "43a4cecb99e48c33a4136346b110d56c8a91472634524071727c5b88afe67fba"
    sha256 cellar: :any_skip_relocation, catalina:      "e0db2e2d2f4331ecbe4ead3c8f9d4f239c6b9427472ea959dd394544fbbf7b43"
    sha256 cellar: :any_skip_relocation, mojave:        "fb50587552693b0c0c26ee074c52766c097f90afc6492a0bcf75cc65aaf2f031"
    sha256 cellar: :any_skip_relocation, high_sierra:   "2460dcc2da525280cd5b7d2452abe922874291b92f0ba3abd1316da2e5ff40f7"
    sha256 cellar: :any_skip_relocation, sierra:        "a0f14e7d01b7098ed6e770b21df05f03d7506ca0bab3d1f84845ca9ca7d1eb5b"
    sha256 cellar: :any_skip_relocation, el_capitan:    "a094d355a75148ed611e9668841a33810a1a1226bc6651b8d0c5e4868867e7fd"
    sha256 cellar: :any_skip_relocation, yosemite:      "fc4f5fc0f1bb13139740ae6f2966bd4e3adb57c7a9803b84f946d95fcb40dd2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad06c2e786a951441517368741d1b785ebb4fcfc9444aee9d6dd626c3d797ca5" # linuxbrew-core
  end

  def install
    inreplace "src/makefile.osx" do |s|
      s.gsub! "-mcpu=powerpc", ""
      s.change_make_var! "CFLAGS", "$(INCS) $(OPTFLGS) #{ENV.cflags}"
      s.change_make_var! "LFLAGS", ""
    end

    system "make", "-C", "src", "-f", "makefile.osx"
    bin.install "bin/cver"
  end
end
