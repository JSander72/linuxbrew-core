class Jemalloc < Formula
  desc "Implementation of malloc emphasizing fragmentation avoidance"
  homepage "http://jemalloc.net/"
  url "https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2"
  sha256 "34330e5ce276099e2e8950d9335db5a875689a4c6a56751ef3b1d8c537f887f6"
  license "BSD-2-Clause"
  revision 1

  bottle do
    sha256 cellar: :any, arm64_big_sur: "724ab5947e53f571b9fed9e776a1ba22b1d71fe27ce5775553d70e990ef9dc63"
    sha256 cellar: :any, big_sur:       "7797788be2da677a8343ac6199e2f180c2e6b627c0b9abc9da133fbc34e86678"
    sha256 cellar: :any, catalina:      "b1b211e5bead798c236d478dd74310a97a7b59470f607b608c07222648b08bf5"
    sha256 cellar: :any, mojave:        "d3f6f85e74b08c8c97448e289734df484f884af35cd10ce9d9db43cf721fbf94"
    sha256 cellar: :any, high_sierra:   "8080c98844153da08346431fe0a0592f6f718cb7a17525f9ffb909c395bc0b6d"
    sha256 cellar: :any, x86_64_linux:  "08def7a0bdddf9311aeca1d40b93f4ac1b8b0c13ded3c66dc8ec44e517cff233" # linuxbrew-core
  end

  head do
    url "https://github.com/jemalloc/jemalloc.git", branch: "dev"

    depends_on "autoconf" => :build
    depends_on "docbook-xsl" => :build
  end

  # Fixes an issue where jemalloc's types conflict with the system
  # types, preventing their use. Merged upstream.
  # https://github.com/jemalloc/jemalloc/commit/3b4a03b92b2e415415a08f0150fdb9eeb659cd52
  patch do
    url "https://github.com/Homebrew/formula-patches/raw/d3d5ad2b5683c1a435a185eec9c593749c7ca41a/jemalloc/fix_nothrow_type.patch"
    sha256 "d79f5c8767695059ff541f291db3fbc57c9b67299dc129848dd365c2f51b214a"
  end

  def install
    args = %W[
      --disable-debug
      --prefix=#{prefix}
      --with-jemalloc-prefix=
    ]

    if build.head?
      args << "--with-xslroot=#{Formula["docbook-xsl"].opt_prefix}/docbook-xsl"
      system "./autogen.sh", *args
      system "make", "dist"
    else
      system "./configure", *args
    end

    system "make"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdlib.h>
      #include <jemalloc/jemalloc.h>

      int main(void) {

        for (size_t i = 0; i < 1000; i++) {
            // Leak some memory
            malloc(i * 100);
        }

        // Dump allocator statistics to stderr
        malloc_stats_print(NULL, NULL, NULL);
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-ljemalloc", "-o", "test"
    system "./test"
  end
end
