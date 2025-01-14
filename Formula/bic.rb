class Bic < Formula
  desc "C interpreter and API explorer"
  homepage "https://github.com/hexagonal-sun/bic"
  url "https://github.com/hexagonal-sun/bic/releases/download/v1.0.0/bic-v1.0.0.tar.gz"
  sha256 "553324e39d87df59930d093a264c14176d5e3aaa24cd8bff276531fb94775100"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any, big_sur:      "36f71fa3f987da036e8bf8cefd3e640479868f2eb033f307848679b41d7ee393"
    sha256 cellar: :any, catalina:     "41d1871d125642f8437b5bb7b74f205b0eee956be0ad46b7677680b76764c0cb"
    sha256 cellar: :any, mojave:       "36575a3c3444985140e94eba8fe8f6711fff5433eb7f17141c4b4ae30e1f2bf7"
    sha256 cellar: :any, high_sierra:  "23f308f2bfda3b9ee498680e08565997818570d74d1280137ef940f70801b8d9"
    sha256 cellar: :any, x86_64_linux: "77e58c48a6bcb0982874c5a465ee59aeaa79573a61b2bae243afebe5eccfe97c" # linuxbrew-core
  end

  head do
    url "https://github.com/hexagonal-sun/bic.git"

    depends_on "autoconf" => :build
    depends_on "autoconf-archive" => :build
    depends_on "automake" => :build
    depends_on "bison" => :build # macOS bison is too outdated, build fails unless gnu bison is used
    depends_on "libtool" => :build

    uses_from_macos "flex" => :build
  end

  depends_on "gmp"

  on_linux do
    depends_on "readline"
  end

  def install
    system "autoreconf", "-fi" if build.head?
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
          "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"hello.c").write <<~EOS
      #include <stdio.h>
      int main () {
        puts("Hello Homebrew!");
      }
    EOS
    assert_equal "Hello Homebrew!", shell_output("#{bin}/bic -s hello.c").strip
  end
end
