class Libvdpau < Formula
  desc "Open source Video Decode and Presentation API library"
  homepage "https://www.freedesktop.org/wiki/Software/VDPAU/"
  url "https://gitlab.freedesktop.org/vdpau/libvdpau/-/archive/1.4/libvdpau-1.4.tar.bz2"
  sha256 "4258824c5a4555ef31de0a7d82b3caf19e75a16a13949f1edafc5f6fb2d33f30"
  license "MIT"

  livecheck do
    url "https://gitlab.freedesktop.org/vdpau/libvdpau.git"
    regex(/^(?:libvdpau[._-])?v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 arm64_big_sur: "08dc576dba7a86a6a7fe5b76a3e988f97203b55a7ec52cfa22316cf734960391"
    sha256 big_sur:       "37a873028601ad2d18ba85aa20c5a0e1b6ffe9bdbce860d4878498d3acd6746e"
    sha256 catalina:      "bec2b355ee24c1bd5a7c399c073ed99f470ab79adb87bdc4bd739ca70bd7b2db"
    sha256 mojave:        "e9580c9e952c63e6a4d02fa3e80255f0fb10c71d6b8ff4815769cd4fb80b42e2"
    sha256 x86_64_linux:  "fff5d6b025320433c9bc4038d0c537803d9ee2502e4813d3a79b4a4071ae6c92" # linuxbrew-core
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "libx11"
  depends_on "libxext"
  depends_on "xorgproto"

  def install
    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
  end
  test do
    assert_match "-I#{include}", shell_output("pkg-config --cflags vdpau")
  end
end
