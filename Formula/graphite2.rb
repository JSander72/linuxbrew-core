class Graphite2 < Formula
  desc "Smart font renderer for non-Roman scripts"
  homepage "https://graphite.sil.org/"
  url "https://github.com/silnrsi/graphite/releases/download/1.3.14/graphite2-1.3.14.tgz"
  sha256 "f99d1c13aa5fa296898a181dff9b82fb25f6cc0933dbaa7a475d8109bd54209d"
  license any_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later", "MPL-1.1+"]
  head "https://github.com/silnrsi/graphite.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "544e2c344f6c0a7c2c3cb6541150f0d0d91cd1100460dac9c6a08578823f91c3"
    sha256 cellar: :any, big_sur:       "ddc468a1eec491aed5d5b05b22d0cffa38b6059d87eab747301011507fcf6366"
    sha256 cellar: :any, catalina:      "0831f474c920b66bbeab3f93a91fa019b82bfffcdd40e369fdab76372700e980"
    sha256 cellar: :any, mojave:        "2f3abb971be03141e9eea54b87c6861d72865bd76fde73ae3161d64c40d51cd9"
    sha256 cellar: :any, high_sierra:   "62e39dce0ae0440ac164edaab6e1351520bc5414ad509fc0b8d5c890500785bd"
    sha256 cellar: :any, x86_64_linux:  "b2e120e5486b9c0b3c2eb5c2597e324d890319f502d2475fabdad1f4080f4e67" # linuxbrew-core
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "freetype" => :build
  end

  resource "testfont" do
    url "https://scripts.sil.org/pub/woff/fonts/Simple-Graphite-Font.ttf"
    sha256 "7e573896bbb40088b3a8490f83d6828fb0fd0920ac4ccdfdd7edb804e852186a"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    resource("testfont").stage do
      shape = shell_output("#{bin}/gr2fonttest Simple-Graphite-Font.ttf 'abcde'")
      assert_match(/67.*36.*37.*38.*71/m, shape)
    end
  end
end
