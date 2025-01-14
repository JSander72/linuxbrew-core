class Zenity < Formula
  desc "GTK+ dialog boxes for the command-line"
  homepage "https://wiki.gnome.org/Projects/Zenity"
  url "https://download.gnome.org/sources/zenity/3.32/zenity-3.32.0.tar.xz"
  sha256 "e786e733569c97372c3ef1776e71be7e7599ebe87e11e8ad67dcc2e63a82cd95"
  revision 1

  bottle do
    sha256 arm64_big_sur: "794e362dfcf2ff4bc5138b4db391df744865b150086fef376c245c6e9b3d9669"
    sha256 big_sur:       "bf8f705cbdadd17fca250b94df00f7a26c345c7476234a312819add6d0534e3d"
    sha256 catalina:      "6bbf833a5a7d71346a5391fae436c2c46f530f0f5b9ac5d57330601b3456db49"
    sha256 mojave:        "cef54fcd5601eb5dd3b563d1a09a6cd83654a2fa46e4a83a3d3c6e6a356fe29a"
    sha256 high_sierra:   "36cf68d4838890e8d9122109464548a4630da0b06dcf6d4f0976ccf58b99dde2"
    sha256 sierra:        "8b06d6cfec84ff39a95aeb4b466c1eb62584ff019ed90331334d243501cc8398"
    sha256 x86_64_linux:  "9de564fbd06063c0e002836e266b5c78cfbd0204084fc0501dd5053c58dfe0a6" # linuxbrew-core
  end

  depends_on "itstool" => :build
  depends_on "pkg-config" => :build
  depends_on "gtk+3"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    on_linux do
      # (zenity:30889): Gtk-WARNING **: 13:12:26.818: cannot open display
      return if ENV["HOMEBREW_GITHUB_ACTIONS"]
    end

    system bin/"zenity", "--help"
  end
end
