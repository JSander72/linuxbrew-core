class Ubertooth < Formula
  desc "Host tools for Project Ubertooth"
  homepage "https://github.com/greatscottgadgets/ubertooth/wiki"
  url "https://github.com/greatscottgadgets/ubertooth/releases/download/2020-12-R1/ubertooth-2020-12-R1.tar.xz"
  version "2020-12-R1"
  sha256 "93a4ce7af8eddcc299d65aff8dd3a0455293022f7fea4738b286353f833bf986"
  license "GPL-2.0-or-later"
  head "https://github.com/greatscottgadgets/ubertooth.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "bc55cb49599e7d93d33472d76f0a77d189baa107849aacf6d50802fa90124e52"
    sha256 cellar: :any, big_sur:       "50379a3b1a31430683af82115ce1c4a77097c23d5b42cfc72d7df9bcb4f408a6"
    sha256 cellar: :any, catalina:      "e08b27b20a6b1b0556e67320e8071e363e6ac0f19751218d87a701ac191b7677"
    sha256 cellar: :any, mojave:        "6a17f9213d8e8bc61ae89b4b976679fd28cd75167b20a8eab55ceeb3282e0d7c"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libbtbb"
  depends_on "libusb"

  def install
    mkdir "host/build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    # Most ubertooth utilities require an ubertooth device present.
    system "#{bin}/ubertooth-rx", "-i", "/dev/null"
  end
end
