class FontUtil < Formula
  desc "X.Org: Font package creation/installation utilities"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/font/font-util-1.3.2.tar.bz2"
  sha256 "3ad880444123ac06a7238546fa38a2a6ad7f7e0cc3614de7e103863616522282"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8cf0aaa2a8712798806bf33f3c08a50a4fd0a71f131e405f0559f133d2bec281"
    sha256 cellar: :any_skip_relocation, big_sur:       "880e773166f076fee6ed2b66aa46ccd786adcdffcb62867d0453f5fb0306fc8d"
    sha256 cellar: :any_skip_relocation, catalina:      "3b1ccaebd2a3efc9cd2daac2e9e740362349a1847e4c169ebe3d475ff3b31a8d"
    sha256 cellar: :any_skip_relocation, mojave:        "c606e6261604b92184fad13ea3fa0cdf377fe09bd3280389ae3c2b32b15b4785"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e5a86e6341ec516e06c3c22cc347ef5329add351e8aeb1f3aac3cf981dd81d51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "433002ceb718eb72f97b9064e2ef8c0837d5ffc091d0f12d6f868825c82da4be" # linuxbrew-core
  end

  depends_on "pkg-config" => [:build, :test]
  depends_on "util-macros" => :build

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  def post_install
    dirs = %w[encodings 75dpi 100dpi misc]
    dirs.each do |d|
      mkdir_p share/"fonts/X11/#{d}"
    end
  end

  test do
    system "pkg-config", "--exists", "fontutil"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
