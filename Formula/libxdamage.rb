class Libxdamage < Formula
  desc "X.Org: X Damage Extension library"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXdamage-1.1.5.tar.bz2"
  sha256 "b734068643cac3b5f3d2c8279dd366b5bf28c7219d9e9d8717e1383995e0ea45"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "bbd5ef8f7408de369198e66bc6aa8a75ddc798c444ebd7f03b885bc25ccfb136"
    sha256 cellar: :any, big_sur:       "68750157664e1290e30b15ad95dbfcc1be2748b85e7eaef0851f2c0f56f043e3"
    sha256 cellar: :any, catalina:      "2c09f29dfafe280bc0179dfe6ad82b623459e6bec07fefac41cf6b3e52385100"
    sha256 cellar: :any, mojave:        "ea0aee131addc90c4b4ba6e0d8c4f8cdfd39dc034a7bfc3e841c408042ad8906"
    sha256 cellar: :any, high_sierra:   "5c0ca5debb8c99cfed432fa2299e4a280ca81f8988aaacf44e0c0194d89ca7ac"
    sha256 cellar: :any, x86_64_linux:  "bfc0ac85f89a4dcc1e94991bef37212d55607dc7c7b9708f3a1845ee9b456c4f" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxfixes"
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
      #include "X11/extensions/Xdamage.h"

      int main(int argc, char* argv[]) {
        XDamageNotifyEvent event;
        return 0;
      }
    EOS
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
