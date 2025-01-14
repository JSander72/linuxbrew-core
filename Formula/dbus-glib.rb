class DbusGlib < Formula
  desc "GLib bindings for the D-Bus message bus system"
  homepage "https://wiki.freedesktop.org/www/Software/DBusBindings/"
  url "https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-0.112.tar.gz"
  sha256 "7d550dccdfcd286e33895501829ed971eeb65c614e73aadb4a08aeef719b143a"

  livecheck do
    url "https://dbus.freedesktop.org/releases/dbus-glib/"
    regex(/href=.*?dbus-glib[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "d87340d630e5e4e08fcaf5c557ad1577736069561e3903f763cb50396b417830"
    sha256 cellar: :any,                 big_sur:       "b8b40647f906afbe0c3c35be698d77b02e22fe204cad83e1cda62842aba68ea2"
    sha256 cellar: :any,                 catalina:      "5f964469ee5636271ebb40d0df69cd2e71dc292cf229b59be6b0a15543016373"
    sha256 cellar: :any,                 mojave:        "ba4476464714dcde25a52ba1a3ae3a9646b9a293ab63ceb2f0ea5fc4192df97a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "befde29c49cd04c10c303fdf0173344411d9ee6c5c971feba2afba0f5e6df925" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "dbus"
  depends_on "gettext"
  depends_on "glib"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"dbus-binding-tool", "--help"
  end
end
