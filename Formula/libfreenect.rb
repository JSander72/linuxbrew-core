class Libfreenect < Formula
  desc "Drivers and libraries for the Xbox Kinect device"
  homepage "https://openkinect.org/"
  url "https://github.com/OpenKinect/libfreenect/archive/v0.6.2.tar.gz"
  sha256 "e135f5e60ae290bf1aa403556211f0a62856a9e34f12f12400ec593620a36bfa"
  license any_of: ["Apache-2.0", "GPL-2.0-only"]
  head "https://github.com/OpenKinect/libfreenect.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "30cae9ff39f3c3416e157532e50781a61c576b2efe2f30c30f7f7cd02d458d93"
    sha256 cellar: :any,                 big_sur:       "7e7be2792089b91924578ffa29711185ab7ae4b20e3d9489fe6c39bb97436867"
    sha256 cellar: :any,                 catalina:      "cdf0630222750f1a4281159cbc161601eb5d02487632b647940af4503e557ebb"
    sha256 cellar: :any,                 mojave:        "5c5d2b1b69179658fec4c9a0e65b3132e69b32f0214ad4a09a75cbf7db1ed9f3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "977d12eb32c3e68f43e6c0ef625e2ed62814ba9b4eaf2f06af7cfb2abb18bd0d" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "libusb"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args,
                      "-DBUILD_OPENNI2_DRIVER=ON"
      system "make", "install"
    end
  end

  test do
    system bin/"fakenect-record", "-h"
  end
end
