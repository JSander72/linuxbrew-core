class Perceptualdiff < Formula
  desc "Perceptual image comparison tool"
  homepage "https://pdiff.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/pdiff/pdiff/perceptualdiff-1.1.1/perceptualdiff-1.1.1-src.tar.gz"
  sha256 "ab349279a63018663930133b04852bde2f6a373cc175184b615944a10c1c7c6a"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "6260c155e96ef17bdaf4ba1032986371db4748e3de145c5354e936fd0f854875"
    sha256 cellar: :any, big_sur:       "fdc7e444e4d48802ce4a7c671260ec1a51ebb100248d4cb90622ce3cb2dfce82"
    sha256 cellar: :any, catalina:      "9edad00fd4470f908e5f9e1eb8c96c364b94c504dab46d1f38a45036871a10a0"
    sha256 cellar: :any, mojave:        "1d3d02c27772801105fe9cf3e3ad697bcbeb4db9b260f134bd3e342344455481"
    sha256 cellar: :any, high_sierra:   "683d05fc64186ee518180b56345d446be90ff2c42666c80adb86bc185d20d283"
    sha256 cellar: :any, sierra:        "eb2da458eda1cebc7872b2621c96e5aa627d9711f8d31fb792cb092d92d060db"
    sha256 cellar: :any, el_capitan:    "d47d680df91ee88897f95123e6b9f972351a603a5f4921726b2877cc2e67924f"
    sha256 cellar: :any, yosemite:      "7a1956479cc1176b7340f4614db1b556318513b6359a025dca942142956b65d9"
  end

  depends_on "cmake" => :build
  depends_on "freeimage"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
