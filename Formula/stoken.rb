class Stoken < Formula
  desc "Tokencode generator compatible with RSA SecurID 128-bit (AES)"
  homepage "https://stoken.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/stoken/stoken-0.92.tar.gz"
  sha256 "aa2b481b058e4caf068f7e747a2dcf5772bcbf278a4f89bc9efcbf82bcc9ef5a"
  revision 1

  bottle do
    sha256 cellar: :any, arm64_big_sur: "2f66cb207fe048720b4497e774752de500d005b4bcc7bd45ccb164ecd11fafc8"
    sha256 cellar: :any, big_sur:       "701102c6cb8138920a8ccf7aae6d89ea247d259d17f7f4ce3e4af46cad516802"
    sha256 cellar: :any, catalina:      "423dbce4e76710fe932fc4d86fa25b39ced8f138d781fcccbc3982ce83136216"
    sha256 cellar: :any, mojave:        "59ee230b63a707bf9c1fd966ec003c14ca16c7e61a331b765e31a1ba4b7db867"
    sha256 cellar: :any, high_sierra:   "6c6b704e5f9830e0192383c53717f64b0af48119d6f0d96d78de521820a6c84b"
    sha256 cellar: :any, x86_64_linux:  "bb36935bef860c89a3d57ede15d330171e967453c0dfc0722dc34ac882d1fb5e" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "nettle"

  uses_from_macos "libxml2"

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-debug
      --disable-silent-rules
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make", "check"
    system "make", "install"
  end

  test do
    system "#{bin}/stoken", "show", "--random"
  end
end
