class Enet < Formula
  desc "Provides a network communication layer on top of UDP"
  homepage "http://enet.bespin.org"
  url "http://enet.bespin.org/download/enet-1.3.17.tar.gz"
  sha256 "a38f0f194555d558533b8b15c0c478e946310022d0ec7b34334e19e4574dcedc"
  license "MIT"
  head "https://github.com/lsalzman/enet.git"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "b2ef2e83fc0f527691e8352d39241277ab742569cc5278a357a53b19a42e700d"
    sha256 cellar: :any, big_sur:       "bb861ad42df5152ac53708cdee14a599ff5e09a06cf3d438e88f7bc6b84590db"
    sha256 cellar: :any, catalina:      "557052d4c6fb7e8c4329270730bd97b032f279c2cfafaa6ebbd32f7ff7e076bf"
    sha256 cellar: :any, mojave:        "7df13b64c909df3368a91094abaaab1563f66ebcb276af0d318408977af08d2f"
    sha256 cellar: :any, high_sierra:   "6fbf495f25b1df30003129b77167df08d26fbb576fa61a3f17ff7eba366bdd2a"
    sha256 cellar: :any, x86_64_linux:  "f79a8f1a3cc20e8952dccb88cd247049e3b5cfc930ce5ac5c2537e386df051d8" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <enet/enet.h>
      #include <stdio.h>

      int main (int argc, char ** argv)
      {
        if (enet_initialize () != 0)
        {
          fprintf (stderr, "An error occurred while initializing ENet.\\n");
          return EXIT_FAILURE;
        }
        atexit (enet_deinitialize);
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lenet", "-o", "test"
    system testpath/"test"
  end
end
