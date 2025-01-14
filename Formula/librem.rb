class Librem < Formula
  desc "Toolkit library for real-time audio and video processing"
  homepage "https://github.com/creytiv/rem"
  url "https://github.com/creytiv/rem/releases/download/v0.6.0/rem-0.6.0.tar.gz"
  sha256 "417620da3986461598aef327c782db87ec3dd02c534701e68f4c255e54e5272c"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "f89cd157675ca8fe3154b27cfeccf20846e40911c74820ccf61d2fb83abd6bfd"
    sha256 cellar: :any,                 big_sur:       "b571b06f4fc31e68adc40869c1e5b415eda6aed48f9093ee844f53f17baf5f44"
    sha256 cellar: :any,                 catalina:      "cfb5f86357e8176a51e80b2ec726e8e38fc002a7dfea8f36256328747df01d9a"
    sha256 cellar: :any,                 mojave:        "5fc70f673166bfc2794c40b440de29cc544cb3d46cccfb538ba868362e6e813a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "725902bfede7ba94e3ea3f60496681fec168fb18bd6d1c70084b0f1c6bb4af93" # linuxbrew-core
  end

  depends_on "libre"

  def install
    libre = Formula["libre"]
    system "make", "install", "PREFIX=#{prefix}",
                              "LIBRE_MK=#{libre.opt_share}/re/re.mk",
                              "LIBRE_INC=#{libre.opt_include}/re",
                              "LIBRE_SO=#{libre.opt_lib}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdint.h>
      #include <re/re.h>
      #include <rem/rem.h>
      int main() {
        return (NULL != vidfmt_name(VID_FMT_YUV420P)) ? 0 : 1;
      }
    EOS
    system ENV.cc, "test.c", "-L#{opt_lib}", "-lrem", "-o", "test"
    system "./test"
  end
end
