class B43Fwcutter < Formula
  desc "Extract firmware from Braodcom 43xx driver files"
  homepage "https://wireless.wiki.kernel.org/en/users/drivers/b43"
  url "https://bues.ch/b43/fwcutter/b43-fwcutter-019.tar.bz2"
  mirror "https://launchpad.net/ubuntu/+archive/primary/+files/b43-fwcutter_019.orig.tar.bz2"
  sha256 "d6ea85310df6ae08e7f7e46d8b975e17fc867145ee249307413cfbe15d7121ce"
  license "BSD-2-Clause"

  livecheck do
    url "https://bues.ch/b43/fwcutter/"
    regex(/href=.*?b43-fwcutter[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0c68725ddd4ab0d3467c8eab623682712e51d180e4517e1fa04518c0aac4c65a"
    sha256 cellar: :any_skip_relocation, big_sur:       "d71a9a74998af98e4593b5593ff415aa4e6f868a9fe7b7fa4814fd27a4b6652d"
    sha256 cellar: :any_skip_relocation, catalina:      "65b60abba52b848bd47386245505719c4c2218429719cf008a6720a4fbcac36a"
    sha256 cellar: :any_skip_relocation, mojave:        "244e2363a7eff64ea8708724a386796d8fbf6d49677519a4132a2296faa0c411"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "250184046afd06e7ac1de8846b0b254349f59ad458263a5e5ab4644a368e3037" # linuxbrew-core
  end

  def install
    inreplace "Makefile" do |m|
      # Don't try to chown root:root on generated files
      m.gsub! "install -o 0 -g 0", "install"
      m.gsub! "install -d -o 0 -g 0", "install -d"
      # Fix manpage installation directory
      m.gsub! "$(PREFIX)/man", man
    end
    # b43-fwcutter has no ./configure
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/b43-fwcutter", "--version"
  end
end
