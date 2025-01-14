class RxvtUnicode < Formula
  desc "Rxvt fork with Unicode support"
  homepage "http://software.schmorp.de/pkg/rxvt-unicode.html"
  url "http://dist.schmorp.de/rxvt-unicode/rxvt-unicode-9.26.tar.bz2"
  sha256 "643116b9a25d29ad29f4890131796d42e6d2d21312282a613ef66c80c5b8c98b"
  license "GPL-3.0-only"

  livecheck do
    url "http://dist.schmorp.de/rxvt-unicode/"
    regex(/href=.*?rxvt-unicode[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "2ad5cfb39d86aff0d7f3b785aee5058ce2b0bf113b13b24f963c1b8d60679ff3"
    sha256 big_sur:       "5e3a94dc348d57ada5dcb55eafee51b1ffa8bf78e10a8a2b0af9ac56b2d2ff02"
    sha256 catalina:      "b97c65d257344a16accd34497c77ec3638674c7c596b7f05c190d606975de9af"
    sha256 mojave:        "ecec482ad2b840b1cdb3945a42bcc31656d61a83ae3d08af2d2dafb1a4002d9d"
    sha256 x86_64_linux:  "e2972b3820386c6672c377b63f665495261957667aaa580ea5a26597f43a44fd" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "libx11"
  depends_on "libxft"
  depends_on "libxmu"
  depends_on "libxrender"
  depends_on "libxt"

  uses_from_macos "perl"

  # Patches 1 and 2 remove -arch flags for compiling perl support
  # Patch 3 fixes `make install` target on case-insensitive filesystems
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/rxvt-unicode/9.22.patch"
    sha256 "a266a5776b67420eb24c707674f866cf80a6146aaef6d309721b6ab1edb8c9bb"
  end

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-256-color
      --with-term=rxvt-unicode-256color
      --with-terminfo=/usr/share/terminfo
      --enable-smart-resize
      --enable-unicode3
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    daemon = fork do
      system bin/"urxvtd"
    end
    sleep 2
    system bin/"urxvtc", "-k"
    Process.wait daemon
  end
end
