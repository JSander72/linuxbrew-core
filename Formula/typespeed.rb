class Typespeed < Formula
  desc "Zap words flying across the screen by typing them correctly"
  homepage "https://typespeed.sourceforge.io"
  url "https://downloads.sourceforge.net/project/typespeed/typespeed/0.6.5/typespeed-0.6.5.tar.gz"
  sha256 "5c860385ceed8a60f13217cc0192c4c2b4705c3e80f9866f7d72ff306eb72961"
  license "GPL-2.0"

  bottle do
    sha256 arm64_big_sur: "bf2143006f2dbbb230b3c899a77fc98c1a056316fc957f195a5fb4b27c388947"
    sha256 big_sur:       "a1624c4d927fda389aceec074f743e73bd10417059764d480141a88fab23bb82"
    sha256 catalina:      "cff9da11f7441f1ff4db7cbfa57f0711ff0bbe08a80ee7067021c619bc01cb06"
    sha256 mojave:        "49c54c15fa8204ca5ae373f0a1995c01b7b6e24de0ab0af7d8081e9f3b229258"
    sha256 high_sierra:   "70fe987eeaabcf8e94996d56a478c1aac14781f2475337476ff2dc87543bb602"
    sha256 sierra:        "8c4af1a3e4e8c32eab5da01fc3b30604eaad86bf84f4a96af7878599c92a4a36"
    sha256 el_capitan:    "82223614505b9fac677ba4ac4ad9f3b646597cddde604f8c981cc000b8ed7bf6"
    sha256 yosemite:      "23d3acaedb26f5bedccc2186dec138679fdea40f036edd57ce84ff363c082206"
  end

  def install
    # Fix the hardcoded gcc.
    inreplace "src/Makefile.in", "gcc", ENV.cc
    inreplace "testsuite/Makefile.in", "gcc", ENV.cc
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
