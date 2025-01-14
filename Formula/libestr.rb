class Libestr < Formula
  desc "C library for string handling (and a bit more)"
  homepage "https://libestr.adiscon.com/"
  url "https://libestr.adiscon.com/files/download/libestr-0.1.11.tar.gz"
  sha256 "46632b2785ff4a231dcf241eeb0dcb5fc0c7d4da8ee49cf5687722cdbe8b2024"
  license "LGPL-2.1"

  livecheck do
    url "https://libestr.adiscon.com/download/"
    regex(/href=.*?libestr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "20863614b37a81431737f276b1273bf542e374a323b9a1e486af7775e659d688"
    sha256 cellar: :any, big_sur:       "11fa154962682f47b57b2dac7ceee697b5cf57c21e56d3c713f6e5a646d318da"
    sha256 cellar: :any, catalina:      "f539c76e3acdd0a93def55a0e82ecf45c53de65dc6dc18fd123efe815d8a65cd"
    sha256 cellar: :any, mojave:        "543dcd541a69d52d5d1d21d51d0cf57c1617cc177f743c2dfea8ea3d548b93e8"
    sha256 cellar: :any, high_sierra:   "7f17c5dbb6534afe6b37ae1d1f994d3387cd8527d6aaa768604837ac681eee59"
    sha256 cellar: :any, sierra:        "5ff130cf6aa42842636dd90b7a8e7e60adbb289682bd915c98937b032c38fc54"
    sha256 cellar: :any, x86_64_linux:  "cd938799f312f00e4b1752e92b89dc31cfb30b680fea6e57c1ae7e74e9374d2d" # linuxbrew-core
  end

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "stdio.h"
      #include <libestr.h>
      int main() {
        printf("%s\\n", es_version());
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lestr", "-o", "test"
    system "./test"
  end
end
