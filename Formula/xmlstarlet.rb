class Xmlstarlet < Formula
  desc "XML command-line utilities"
  homepage "https://xmlstar.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/xmlstar/xmlstarlet/1.6.1/xmlstarlet-1.6.1.tar.gz"
  sha256 "15d838c4f3375332fd95554619179b69e4ec91418a3a5296e7c631b7ed19e7ca"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d654b90521d07ffc1304253fd2b927f9813effa5a65c3f6c43b67838077c009d"
    sha256 cellar: :any_skip_relocation, big_sur:       "bc3baa847a617f3d67000ff14e96126f9bbdf54e916b6c693a2c8bf633ca0bfa"
    sha256 cellar: :any_skip_relocation, catalina:      "2a679570811f553e345748516fa37c2d4b529a75533bdb73316077aaed5ab8f6"
    sha256 cellar: :any_skip_relocation, mojave:        "6e5d11ee1419a61a9f043663c1236d064ee692fd187ae15bf2114b42d8f0889e"
    sha256 cellar: :any_skip_relocation, high_sierra:   "56ce0e3190080e6e1111ebb31aa06aea53f16cde50359a356c24ff86a4df72b3"
    sha256 cellar: :any_skip_relocation, sierra:        "4958bf868beefb9a2b391c0fe05f5289b67a4cded708d71c4cc5fced130bac55"
    sha256 cellar: :any_skip_relocation, el_capitan:    "2d9a9b5f875b91c78378e7f3df12595528d8e4b9ec9e321131b7f9f78f30acd8"
    sha256 cellar: :any_skip_relocation, yosemite:      "525eafe6cab96cc6e04fef756e25316119b3c96cb61e5f7f51770cd062ad1bec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88b419a7af11d19f44e0450b8f50ae1c56a75d4b04124ad612e2ea15db557f3f" # linuxbrew-core
  end

  uses_from_macos "libxslt"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    system "make", "install"
    bin.install_symlink "xml" => "xmlstarlet"
  end

  test do
    system "#{bin}/xmlstarlet", "--version"
  end
end
