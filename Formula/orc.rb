class Orc < Formula
  desc "Oil Runtime Compiler (ORC)"
  homepage "https://gstreamer.freedesktop.org/projects/orc.html"
  url "https://gstreamer.freedesktop.org/src/orc/orc-0.4.32.tar.xz"
  sha256 "a66e3d8f2b7e65178d786a01ef61f2a0a0b4d0b8370de7ce134ba73da4af18f0"

  livecheck do
    url "https://gstreamer.freedesktop.org/src/orc/"
    regex(/href=.*?orc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "657bdaa5b945e5071ae862066b4f703750890b106facb3528c9e649beada7c30"
    sha256 cellar: :any, big_sur:       "7c5d9d6caf789828006ff7d604eb81a247c8d9ff6004c524978452a252dd8162"
    sha256 cellar: :any, catalina:      "df8ed6c8e2d13c9425174f38a6ff60d291cc3febababa670ebe74b21fe56ceab"
    sha256 cellar: :any, mojave:        "8b11d82f1c1e51fe41d4b7cf1a905f72bdb977ce2acc0eafcf2ba6b89f06d58c"
    sha256 cellar: :any, high_sierra:   "d347537787016fa19c7653a9912e0c11d134f10e96a75bc0f5bb28e221e012d8"
    sha256 cellar: :any, x86_64_linux:  "40d56f593ecf67d184f45482de66f7dc357abae1f7fb5e9cf53efa79d57786ad" # linuxbrew-core
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    mkdir "build" do
      system "meson", *std_meson_args, "-Dgtk_doc=disabled", ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "#{bin}/orcc", "--version"
  end
end
