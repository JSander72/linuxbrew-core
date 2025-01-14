class Zyre < Formula
  desc "Local Area Clustering for Peer-to-Peer Applications"
  homepage "https://github.com/zeromq/zyre"
  url "https://github.com/zeromq/zyre/releases/download/v2.0.1/zyre-2.0.1.tar.gz"
  sha256 "0ba43fcdf70fa1f35b068843a90fdf50b34d65a9be7f2c193924a87a4031a98c"
  license "MPL-2.0"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "3b1d36e1f9441e338916cbc75e8701386fbeaa4c23a231061c4d6d08bc35a3f1"
    sha256 cellar: :any, big_sur:       "490a76ad5536efec4b40234fd693f67f7f4b0222672e0b0f39c36d2581b0f4ee"
    sha256 cellar: :any, catalina:      "3fca3e3402fa228c40c3e2263520be64b59c414d1454b7799bb284d711a75d62"
    sha256 cellar: :any, mojave:        "bea4248272a0c99db13a9f8c48cbbbdd1c9927b9b206689ad3b558eadef102b1"
  end

  head do
    url "https://github.com/zeromq/zyre.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "czmq"
  depends_on "zeromq"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "check-verbose"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <zyre.h>

      int main()
      {
        uint64_t version = zyre_version ();
        assert(version >= 2);

        zyre_test(true);
        return 0;
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lzyre", "-o", "test"
    system "./test"
  end
end
