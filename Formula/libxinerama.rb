class Libxinerama < Formula
  desc "X.Org: API for Xinerama extension to X11 Protocol"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXinerama-1.1.4.tar.bz2"
  sha256 "0008dbd7ecf717e1e507eed1856ab0d9cf946d03201b85d5dcf61489bb02d720"
  license "MIT"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "f372ba853bd1ce9ef1c38d575e1ac3f2e7d5bdcba4ed938a87dfb017c9c0d5f2"
    sha256 cellar: :any, big_sur:       "65b34fb9bd42fdf249ed942d470061da35456794b860863fd6997dd1b3c665fc"
    sha256 cellar: :any, catalina:      "7a008044d1824d0585b13cba7021ec038bda6485a8789337cd6a9fd305b83233"
    sha256 cellar: :any, mojave:        "c69df5fe02995fbbf085b26da9ae1af4b890b2d57d1e8d115253706486297e5f"
    sha256 cellar: :any, high_sierra:   "27a945b6652dd0c36b3360ca55de687dd350feca08fc0e32bafe71d06edca377"
    sha256 cellar: :any, x86_64_linux:  "06134907802d953c75bc8740121fb3ad2345e1b33d55370d09b2c92e2465f96c" # linuxbrew-core
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
      #include "X11/extensions/Xinerama.h"

      int main(int argc, char* argv[]) {
        XineramaScreenInfo info;
        return 0;
      }
    EOS
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
