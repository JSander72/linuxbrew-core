class Libimobiledevice < Formula
  desc "Library to communicate with iOS devices natively"
  homepage "https://www.libimobiledevice.org/"
  url "https://github.com/libimobiledevice/libimobiledevice/releases/download/1.3.0/libimobiledevice-1.3.0.tar.bz2"
  sha256 "53f2640c6365cd9f302a6248f531822dc94a6cced3f17128d4479a77bd75b0f6"
  license "LGPL-2.1"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "41a64c9856f7845bb4c21bba4f42eb55c640301b59c032eb4db416db19ecf97d"
    sha256 cellar: :any, big_sur:       "0fe21433f470130b972354d411d05f43ab37d82198565bb6b947734a95e98c5d"
    sha256 cellar: :any, catalina:      "eb7f28d86797461d5ef859d00629176e1ce3234790ef17b9ee3f9c9990a664e2"
    sha256 cellar: :any, mojave:        "5143eaf34011a22dd1951f10495a7568e77a2e862fb9f4dbae9bab2f784f926e"
    sha256 cellar: :any, high_sierra:   "072d224a0fa2a77bccde27eee39b65300a387613b41f07fc677108a7812ec003"
    sha256 cellar: :any, x86_64_linux:  "4aee409e60e657edc0f5127aafd198cdf4a09aece3c296ad55702644572518f3" # linuxbrew-core
  end

  head do
    url "https://git.libimobiledevice.org/libimobiledevice.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libplist"
  depends_on "libtasn1"
  depends_on "libusbmuxd"
  depends_on "openssl@1.1"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          # As long as libplist builds without Cython
                          # bindings, libimobiledevice must as well.
                          "--without-cython",
                          "--enable-debug-code"
    system "make", "install"
  end

  test do
    system "#{bin}/idevicedate", "--help"
  end
end
