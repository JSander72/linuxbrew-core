class Goocanvas < Formula
  desc "Canvas widget for GTK+ using the Cairo 2D library for drawing"
  homepage "https://wiki.gnome.org/Projects/GooCanvas"
  url "https://download.gnome.org/sources/goocanvas/2.0/goocanvas-2.0.4.tar.xz"
  sha256 "c728e2b7d4425ae81b54e1e07a3d3c8a4bd6377a63cffa43006045bceaa92e90"
  revision 2

  bottle do
    sha256 arm64_big_sur: "afc6329ef248fba21b033b7f9e409112260e28f0c9964e5748df4bed40a0cdae"
    sha256 big_sur:       "31471c7264bf173c9f82ba40daec0555403f9007cc8046d7bee5b2406bfeedae"
    sha256 catalina:      "ff71ce064b86b1e8973ee5c6aaebdbba6a1159614f5c425d83cc3fb6b00e8b97"
    sha256 mojave:        "b9d36364339793b428077bbc7735981f8cd33e681971653806dc574236382778"
    sha256 high_sierra:   "6822fe0a452809ce94bc1fd70fb32b024ad52702a56878db381b7dad2e05aa28"
    sha256 sierra:        "44b1bd9f058cd4fe112cd1022a0ad2daa93c7f849257ae57bc6d10f9c33e57de"
    sha256 x86_64_linux:  "128ca78ced485aab93ad7b9e996c9b7f9838ea3b7d2d88d92b027b116137a29c" # linuxbrew-core
  end

  depends_on "gobject-introspection" => :build
  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "glib"
  depends_on "gtk+3"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-introspection=yes",
                          "--disable-gtk-doc-html"
    system "make", "install"
  end
end
