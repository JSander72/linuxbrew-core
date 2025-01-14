class Zsdx < Formula
  desc "Zelda Mystery of Solarus DX"
  homepage "https://www.solarus-games.org/en/games/the-legend-of-zelda-mystery-of-solarus-dx"
  url "https://gitlab.com/solarus-games/zsdx/-/archive/v1.12.3/zsdx-v1.12.3.tar.bz2"
  sha256 "29065d3280ec03176e8de0a7a26504421d43c5778b566e50c212deb25b45d66a"
  head "https://gitlab.com/solarus-games/zsdx.git", branch: "dev"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:  "3267503e66537fe829db44b5d36d97200c78911f171659e9c5fc66912beea4fa"
    sha256 cellar: :any_skip_relocation, catalina: "bf58b35d61058612b8497abcc7c29930b1b6d6f9ea0aa7b88bc00ae7181b1f35"
    sha256 cellar: :any_skip_relocation, mojave:   "332fd78f55b41f593403d76839cd51befb586f34036c89a43446c3f39a240d3b"
  end

  depends_on "cmake" => :build
  depends_on "solarus"

  def install
    system "cmake", ".", *std_cmake_args, "-DSOLARUS_INSTALL_DATADIR=#{share}"
    system "make", "install"
  end

  test do
    system Formula["solarus"].bin/"solarus-run", "-help"
    system "/usr/bin/unzip", pkgshare/"data.solarus"
  end
end
