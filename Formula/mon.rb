class Mon < Formula
  desc "Monitor hosts/services/whatever and alert about problems"
  homepage "https://github.com/visionmedia/mon"
  url "https://github.com/visionmedia/mon/archive/1.2.3.tar.gz"
  sha256 "978711a1d37ede3fc5a05c778a2365ee234b196a44b6c0c69078a6c459e686ac"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "65f144b16a687002f9d30ac665886aa8b06bb914e4ff0fe04e692a6a153eb76b"
    sha256 cellar: :any_skip_relocation, big_sur:       "6530e73e7a94297f2646a079361df7076cbc6a881b5baf227a703f1edd92cecc"
    sha256 cellar: :any_skip_relocation, catalina:      "becdcce9ec6a3ec5156cf27db02c50c26e99a9db9626c864abf9eb2f178ea57e"
    sha256 cellar: :any_skip_relocation, mojave:        "ac4640eab6cb255b7cc14f7009b5e8c5a18f9b623559950a1e6d55eb134d483e"
    sha256 cellar: :any_skip_relocation, high_sierra:   "66fe59cb8307fd1371885fe1739a824d01becb1644a8480f8e27584726494f09"
    sha256 cellar: :any_skip_relocation, sierra:        "0d22815460538deda7a6a979d0b7dcdf38124ed9473764f6a90d8252cb9bf1aa"
    sha256 cellar: :any_skip_relocation, el_capitan:    "4f2d05a85fac75167df3a445a0803f7d5eddb2bacf967b10738db5066955024a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b5dc95af7db0ef217f36b2d8886390bcede384108ccb51b22a443cfe49a0f288" # linuxbrew-core
  end

  def install
    bin.mkpath
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"mon", "-V"
  end
end
