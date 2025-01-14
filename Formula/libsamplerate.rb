class Libsamplerate < Formula
  desc "Library for sample rate conversion of audio data"
  homepage "http://www.mega-nerd.com/SRC"
  url "http://www.mega-nerd.com/SRC/libsamplerate-0.1.9.tar.gz"
  sha256 "0a7eb168e2f21353fb6d84da152e4512126f7dc48ccb0be80578c565413444c1"
  license "BSD-2-Clause"
  revision 1

  livecheck do
    url "http://www.mega-nerd.com/SRC/download.html"
    regex(/href=.*?libsamplerate[._-]v?(\d+(?:\.\d+)+)\.t[^.]+(?:\.[^.]+)?["' >]/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "15a9996d530a20df675b808e5cd2d90c506f419c083f0deeb7c361cb6776733d"
    sha256 cellar: :any, big_sur:       "1181186b50d4232509d88f4f8f7fe8e016adb220cc529c5cc84b6d91abaef08c"
    sha256 cellar: :any, catalina:      "36215e2af706686ca333a685a08121d4516d831d0ab99e4188002b7ceb5886c9"
    sha256 cellar: :any, mojave:        "cf0ae6a23af23ce858c7c4301e3c487013d46bca1859cf2b5642068a3b7da861"
    sha256 cellar: :any, high_sierra:   "6003a546793b85dcba886124b962a3ea332ea35cacce64a1cb1af9af94437807"
    sha256 cellar: :any, x86_64_linux:  "a9fbabc956fcbd9d5d3ae37fb785a930631163647668d2ac79ca0fcf3d332004" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libsndfile"

  # configure adds `/Developer/Headers/FlatCarbon` to the include, but this is
  # very deprecated. Correct the use of Carbon.h to the non-flat location.
  # See: https://github.com/Homebrew/homebrew/pull/10875
  patch :DATA

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # Generated by: sox -r 22050 -e signed -b 8 -c 1 -t raw "|printf 'uh'" music.wav
    (testpath/"music.wav").write "RIFF&\0\0\0WAVEfmt \x10\0\0\0\1\0\1\0\"V\0\0\"V\0\0\1\0\b\0data\2\0\0\0\xF5\xE8"
    system "#{bin}/sndfile-resample", "-to", "44100", "music.wav", "upsampled.wav"
    assert_equal 48, (testpath/"upsampled.wav").size
  end
end

__END__
--- a/examples/audio_out.c	2011-07-12 16:57:31.000000000 -0700
+++ b/examples/audio_out.c	2012-03-11 20:48:57.000000000 -0700
@@ -168,7 +168,7 @@
 
 #if (defined (__MACH__) && defined (__APPLE__)) /* MacOSX */
 
-#include <Carbon.h>
+#include <Carbon/Carbon.h>
 #include <CoreAudio/AudioHardware.h>
 
 #define	MACOSX_MAGIC	MAKE_MAGIC ('M', 'a', 'c', ' ', 'O', 'S', ' ', 'X')
