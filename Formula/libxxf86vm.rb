class Libxxf86vm < Formula
  desc "X.Org: XFree86-VidMode X extension"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXxf86vm-1.1.4.tar.bz2"
  sha256 "afee27f93c5f31c0ad582852c0fb36d50e4de7cd585fcf655e278a633d85cd57"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "c2f52435112da27491da0d3f8aae83ac4153bc17b2c8840d553c0556792eac52"
    sha256 cellar: :any, big_sur:       "3443b4465d3839bcee9bbf60a1028b0acfa45877f9b8bfd2654ca42ad1087d46"
    sha256 cellar: :any, catalina:      "0a4d6a9d0b98bd8b8cd2aa2025b6ee80a19ffca34744fed599ef0e754d9e810b"
    sha256 cellar: :any, mojave:        "c89b765023eb0b6820cbf776d6af714363dc6ebd1ea000e1e53a99fa79be4a0d"
    sha256 cellar: :any, high_sierra:   "37cf2b440d8d4e7cda6aa70d070cd45427cebc61781b6c1b3aec153bf82d638d"
    sha256 cellar: :any, x86_64_linux:  "3f2182663cf20729f2236026e21edbde1f34918b1c267d742ad6ffc818d5aa76" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "xorgproto"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "X11/Xlib.h"
      #include "X11/extensions/xf86vmode.h"

      int main(int argc, char* argv[]) {
        XF86VidModeModeInfo mode;
        return 0;
      }
    EOS
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
