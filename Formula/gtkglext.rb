class Gtkglext < Formula
  desc "OpenGL extension to GTK+"
  homepage "https://developer.gnome.org/gtkglext/stable/"
  url "https://download.gnome.org/sources/gtkglext/1.2/gtkglext-1.2.0.tar.gz"
  sha256 "e5073f3c6b816e7fa67d359d9745a5bb5de94a628ac85f624c992925a46844f9"
  revision 3

  bottle do
    rebuild 2
    sha256 cellar: :any, arm64_big_sur: "0e7132d3e408cb5d9bbff6e8f6e93bc6460ebbb4f3e6f365d8cb331edee9435a"
    sha256 cellar: :any, big_sur:       "b367a1ac2118e2bf146d4efd53f5c7b3870b1f0e123ebfc072edf3e1c7eee8d6"
    sha256 cellar: :any, catalina:      "34d57545ff116ecf21f8e6f8695a6a20ac8f1fe90439be0f166420d4623b0050"
    sha256 cellar: :any, mojave:        "aa701707e57b30e6bba5e9f4b28993e7393d43f471994a46572daaee6d678a55"
    sha256 cellar: :any, high_sierra:   "6862527d7b86b6940a38f9fb189085d80b6ea67ee80adc2794e550999e8cc86c"
  end

  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "gtk+"

  # All these MacPorts patches have already been included upstream. A new release
  # of gtkglext for gtk+2.0 remains uncertain though.
  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-configure.diff"
    sha256 "aca35cd6ae28613b375301068715f82b59bd066a32b2f4d046177478950ab026"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-examples-pixmap-mixed.c.diff"
    sha256 "d2fe00bfcf96b3c78dd4b01aa119a7860a34ca6080c57f0ccc7a8e2fc4a3c92b"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-examples-pixmap.c.diff"
    sha256 "d955b18784d3e83c1f698e63875d98de5bad9eae1e84b66549dfe25d9ff94d51"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-gdk-gdkglglext.h.diff"
    sha256 "a1b6a97016013d5cda73760bbf2a970bae318153c2810291b81bd49ed67de80b"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-gdk-gdkglquery.c.diff"
    sha256 "a419b8d523f123d1ab59e4de1105cdfc72bf5a450db8031809dcbc84932b539f"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-gdk-gdkglshapes.c.diff"
    sha256 "bc01fccec833f7ede39ee06ecc2a2ad5d2b30cf703dc66d2a40a912104c6e1f5"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-gdk-makefile.in.diff"
    sha256 "d0bc857f258640bf4f423a79e8475e8cf86e24f9994c0a85475ce87f41bcded6"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-gtk-gtkglwidget.c.diff"
    sha256 "7f7918d5a83c8f36186026a92587117a94014e7b21203fe9eb96a1c751c3c317"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-gtk-makefile.in.diff"
    sha256 "49f58421a12c2badd84ae6677752ba9cc23c249dac81987edf94abaf0d088ff6"
  end

  patch :p0 do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/21e7e01/gtkglext/patch-makefile.in.diff"
    sha256 "0d112b417d6c51022e31701037aa49ea50f270d3a34c263599ac0ef64c2f6743"
  end

  patch :p0 do
    url "https://trac.macports.org/raw-attachment/ticket/56260/patch-index-gdkglshapes-osx.diff"
    sha256 "699ddd676b12a6c087e3b0a7064cc9ef391eac3d84c531b661948bf1699ebcc5"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--without-x"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <gtk/gtkgl.h>

      int main(int argc, char *argv[]) {
        int version_check = GTKGLEXT_CHECK_VERSION(1, 2, 0);
        return 0;
      }
    EOS
    atk = Formula["atk"]
    cairo = Formula["cairo"]
    fontconfig = Formula["fontconfig"]
    freetype = Formula["freetype"]
    gdk_pixbuf = Formula["gdk-pixbuf"]
    gettext = Formula["gettext"]
    glib = Formula["glib"]
    gtkx = Formula["gtk+"]
    harfbuzz = Formula["harfbuzz"]
    libpng = Formula["libpng"]
    pango = Formula["pango"]
    pixman = Formula["pixman"]
    flags = %W[
      -I#{atk.opt_include}/atk-1.0
      -I#{cairo.opt_include}/cairo
      -I#{fontconfig.opt_include}
      -I#{freetype.opt_include}/freetype2
      -I#{gdk_pixbuf.opt_include}/gdk-pixbuf-2.0
      -I#{gettext.opt_include}
      -I#{glib.opt_include}/glib-2.0
      -I#{glib.opt_lib}/glib-2.0/include
      -I#{gtkx.opt_include}/gtk-2.0
      -I#{gtkx.opt_lib}/gtk-2.0/include
      -I#{harfbuzz.opt_include}/harfbuzz
      -I#{include}/gtkglext-1.0
      -I#{libpng.opt_include}/libpng16
      -I#{lib}/gtkglext-1.0/include
      -I#{pango.opt_include}/pango-1.0
      -I#{pixman.opt_include}/pixman-1
      -D_REENTRANT
      -L#{atk.opt_lib}
      -L#{cairo.opt_lib}
      -L#{gdk_pixbuf.opt_lib}
      -L#{gettext.opt_lib}
      -L#{glib.opt_lib}
      -L#{gtkx.opt_lib}
      -L#{lib}
      -L#{pango.opt_lib}
      -latk-1.0
      -lcairo
      -lgdk-quartz-2.0
      -lgdk_pixbuf-2.0
      -lgdkglext-quartz-1.0
      -lgio-2.0
      -lglib-2.0
      -lgmodule-2.0
      -lgobject-2.0
      -lgtk-quartz-2.0
      -lgtkglext-quartz-1.0
      -lintl
      -lpango-1.0
      -lpangocairo-1.0
      -framework AppKit
      -framework OpenGL
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
