class Svgbob < Formula
  desc "Convert your ascii diagram scribbles into happy little SVG"
  homepage "https://ivanceras.github.io/svgbob-editor/"
  url "https://github.com/ivanceras/svgbob/archive/0.6.2.tar.gz"
  sha256 "bf4a545ad18b721b5d9d56947329fd1aab4179431a147a0fe445d43aebecf94a"
  license "Apache-2.0"
  head "https://github.com/ivanceras/svgbob.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "809e9e605211d42102857ac57f3e37636b852babc2e525534c5c863af36d5b59"
    sha256 cellar: :any_skip_relocation, big_sur:       "19911583205a4ffd4be502cab52f491aa280b096059005ef8acc54993479f2b6"
    sha256 cellar: :any_skip_relocation, catalina:      "dff771f864d9a9c735c173facbfeb608f686cc050ac4c7a61c0f22ca720db800"
    sha256 cellar: :any_skip_relocation, mojave:        "5d42a1aefc9b2b1a72d7ebe39478c3e18a6fe0cabc43ad7ccff2109ac7fc7c04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a4a5f244226ea59a1372381a967c6b6155eb971edf6676ac8a138c79afa1541e" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "packages/cli")
  end

  test do
    (testpath/"ascii.txt").write <<~EOS
      +------------------+
      |                  |
      |  Hello Homebrew  |
      |                  |
      +------------------+
    EOS

    system bin/"svgbob", "ascii.txt", "-o", "out.svg"
    contents = (testpath/"out.svg").read
    assert_match %r{<text.*?>Hello</text>}, contents
    assert_match %r{<text.*?>Homebrew</text>}, contents
  end
end
