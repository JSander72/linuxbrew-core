class Nfcutils < Formula
  desc "Near Field Communication (NFC) tools under POSIX systems"
  homepage "https://github.com/nfc-tools/nfcutils"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/nfc-tools/nfcutils-0.3.2.tar.gz"
  sha256 "dea258774bd08c8b7ff65e9bed2a449b24ed8736326b1bb83610248e697c7f1b"
  license "GPL-3.0"
  revision 1

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "257b8265cf3e136dd2a11c3b26b37f31cc3de371d97401a5fadaf1681330fbd8"
    sha256 cellar: :any,                 big_sur:       "ae40ef6e8f1d98d6fc6114893715c713c28e0747a5c5a84779c89726970f8a95"
    sha256 cellar: :any,                 catalina:      "963e5bf77bc285e81b9f7480f8b0362c73e5138bced77608043742df6e0992cd"
    sha256 cellar: :any,                 mojave:        "972af2e69529bde17b450d36ccfbb4b9d124c59beb7bb4d69a9c63b76f7cff58"
    sha256 cellar: :any,                 high_sierra:   "44dc64d49e9edc0c7b8f22c7f259262d5706f83bb452099b968b9f3576047367"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36cef625c3d5b297c8093422b704c88fb9f6a64a16a25d7b801e0ddbb63e004a" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libnfc"
  depends_on "libusb"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
