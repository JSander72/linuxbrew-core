class Mpdecimal < Formula
  desc "Library for decimal floating point arithmetic"
  homepage "https://www.bytereef.org/mpdecimal/"
  url "https://www.bytereef.org/software/mpdecimal/releases/mpdecimal-2.5.1.tar.gz"
  sha256 "9f9cd4c041f99b5c49ffb7b59d9f12d95b683d88585608aa56a6307667b2b21f"
  license "BSD-2-Clause"

  livecheck do
    url "https://www.bytereef.org/mpdecimal/download.html"
    regex(/href=.*?mpdecimal[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "eebbc5c7e71710c848eb60b90f946aefdee1b5269c840c30b8098d6bb758500b"
    sha256 cellar: :any,                 big_sur:       "255b6226cdcfaf0d40167012593e863e73dfed2884c10e7fc3eb4018e81712df"
    sha256 cellar: :any,                 catalina:      "1a8314428019cec85756be0ea10bc4703cd754ef78a4cb560ddcc559af616a72"
    sha256 cellar: :any,                 mojave:        "eebb16e048219e5e3d298db0e7ff8a7bfea60d54c4cf08af76efd81647f1b38b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed8fc5c5367e699f222010c2a387785f64dfa185c536843eb5f5cf3ae0b3ce3c" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <mpdecimal.h>
      #include <string.h>

      int main() {
        mpd_context_t ctx;
        mpd_t *a, *b, *result;
        char *rstring;

        mpd_defaultcontext(&ctx);

        a = mpd_new(&ctx);
        b = mpd_new(&ctx);
        result = mpd_new(&ctx);

        mpd_set_string(a, "0.1", &ctx);
        mpd_set_string(b, "0.2", &ctx);
        mpd_add(result, a, b, &ctx);
        rstring = mpd_to_sci(result, 1);

        assert(strcmp(rstring, "0.3") == 0);

        mpd_del(a);
        mpd_del(b);
        mpd_del(result);
        mpd_free(rstring);

        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-lmpdec"
    system "./test"
  end
end
