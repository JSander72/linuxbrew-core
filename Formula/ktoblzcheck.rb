class Ktoblzcheck < Formula
  desc "Library for German banks"
  homepage "https://ktoblzcheck.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ktoblzcheck/ktoblzcheck-1.53.tar.gz"
  sha256 "18b9118556fe83240f468f770641d2578f4ff613cdcf0a209fb73079ccb70c55"
  license "LGPL-2.1-or-later"
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/ktoblzcheck[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 arm64_big_sur: "2680587208310fe00870bdbdc4ae0af5446c4cee7e3c3e53ba1839004450f0ed"
    sha256 big_sur:       "11c08b9ae4ce285d404ee1eeba912f8bb37b44fe1a142372d366f6233f7e111e"
    sha256 catalina:      "b7abb3dd65cefac9c8ebe1f54482c42adc6a4dbc2c6e3f18452f4b500d5d9aa5"
    sha256 mojave:        "94c9812c2bcffef71b7e6805fa0f54b4a17cc52cb92dadb87fd804fcfab97701"
    sha256 high_sierra:   "39e8b0149fcd448eddace995b7dc37331716b25a5f77b2be5f7b3eb462635854"
    sha256 x86_64_linux:  "7c781479dffd045accdb5ab0057766857adde9f21b64d2d45f59fc7d774d2748" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "python@3.9"

  def install
    system "cmake", ".", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{opt_lib}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Ok", shell_output("#{bin}/ktoblzcheck --outformat=oneline 10000000 123456789")
    assert_match "unknown", shell_output("#{bin}/ktoblzcheck --outformat=oneline 12345678 100000000", 3)
  end
end
