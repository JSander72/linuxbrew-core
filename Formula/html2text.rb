class Html2text < Formula
  desc "Advanced HTML-to-text converter"
  homepage "http://www.mbayer.de/html2text/"
  url "https://github.com/grobian/html2text/archive/v2.0.0.tar.gz"
  sha256 "061125bfac658c6d89fa55e9519d90c5eeb3ba97b2105748ee62f3a3fa2449de"
  license "GPL-2.0"
  head "https://github.com/grobian/html2text.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b8628bce5605c486669b45437ad499b2b3a51901fcb934a031f4dc16be46ce85"
    sha256 cellar: :any_skip_relocation, big_sur:       "f15e51b4bab96810d81f13f7a47cebdc0228e6367c9583918f1437275921d2d1"
    sha256 cellar: :any_skip_relocation, catalina:      "567d2c7e25a24c445ad54074e9ff3ee6edfce3fe7fe960966dcd49a488b2affb"
    sha256 cellar: :any_skip_relocation, mojave:        "55a8fe864bc8e05e7e2fa0085e22adb251fdeeee3fd463e326224a3dff78c773"
    sha256 cellar: :any_skip_relocation, high_sierra:   "b0c913f98f9169669395d57c28c45d7d6c1dc68c13fdb82ba52a04fefdb00bc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22528fa5cb383f88fe7ffcd7dc1fe2c763420e6aa50b23cd8d9f19a9d32728cc" # linuxbrew-core
  end

  def install
    ENV.cxx11

    system "./configure", "--disable-dependency-tracking",
                          "--disable-debug",
                          "--prefix=#{prefix}"
    system "make", "all"

    bin.install "html2text"
    man1.install "html2text.1"
    man5.install "html2textrc.5"
  end

  test do
    path = testpath/"index.html"
    path.write <<~EOS
      <!DOCTYPE html>
      <html>
        <head><title>Home</title></head>
        <body><p>Hello World</p></body>
      </html>
    EOS

    output = `#{bin}/html2text #{path}`.strip
    assert_equal "Hello World", output
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
