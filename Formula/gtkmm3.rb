class Gtkmm3 < Formula
  desc "C++ interfaces for GTK+ and GNOME"
  homepage "https://www.gtkmm.org/"
  url "https://download.gnome.org/sources/gtkmm/3.24/gtkmm-3.24.5.tar.xz"
  sha256 "856333de86689f6a81c123f2db15d85db9addc438bc3574c36f15736aeae22e6"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    regex(/gtkmm[._-]v?(3\.([0-8]\d*?)?[02468](?:\.\d+)*?)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "498012a6736839227f226c7ffa61c765af0c9b0a529c94ab29e4973038b7dec5"
    sha256 cellar: :any,                 big_sur:       "8d16cc9c24d41df916fc4018cd1a678cd99612583dd15afe553baeda150d784e"
    sha256 cellar: :any,                 catalina:      "a029910a18eb883a7e02551a5b0e35696497a6fcafd5df4c03e32ca4a9583f58"
    sha256 cellar: :any,                 mojave:        "52e930043442ed8c29c081c111d4f8e645744c07c4ef8f29bdbec9b1bb512371"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3a70e7c52fc5c7d1375f30301e678322f260737ca5e32dfa237098ec18cf63f" # linuxbrew-core
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => [:build, :test]
  depends_on "atkmm@2.28"
  depends_on "cairomm@1.14"
  depends_on "gtk+3"
  depends_on "pangomm@2.46"

  def install
    ENV.cxx11

    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <gtkmm.h>
      class MyLabel : public Gtk::Label {
        MyLabel(Glib::ustring text) : Gtk::Label(text) {}
      };
      int main(int argc, char *argv[]) {
        return 0;
      }
    EOS
    flags = shell_output("#{Formula["pkg-config"].opt_bin}/pkg-config --cflags --libs gtkmm-3.0").strip.split
    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", *flags
    system "./test"
  end
end
