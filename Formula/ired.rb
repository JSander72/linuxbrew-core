class Ired < Formula
  desc "Minimalistic hexadecimal editor designed to be used in scripts"
  homepage "https://github.com/radare/ired"
  url "https://github.com/radare/ired/archive/0.6.tar.gz"
  sha256 "c15d37b96b1a25c44435d824bd7ef1f9aea9dc191be14c78b689d3156312d58a"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8c5fc028d62ce70b95c2f4ae6e9ec78c88b1083d7244263e5cae2734f9f1f682"
    sha256 cellar: :any_skip_relocation, big_sur:       "383839a113477cfad0b9197aa5e1e5c07ca5248057da840617354552ea35e6dc"
    sha256 cellar: :any_skip_relocation, catalina:      "e74475e811c38aa46bf3e7e69e0a264a2d30c08cfcbd801433e03c14944b8366"
    sha256 cellar: :any_skip_relocation, mojave:        "7821d818af4c7d28b4cbf26c627685b77f18a1004369d4a57bee2582620008b7"
    sha256 cellar: :any_skip_relocation, high_sierra:   "f6af714455a74c02769c9726855a92832e43c37c79a0c589a0c7744beac8956c"
    sha256 cellar: :any_skip_relocation, sierra:        "5d10dfac87e4a4ca589a9fa76e8f9aff62625ef6358b6ab29360e79fe4a6dc35"
    sha256 cellar: :any_skip_relocation, el_capitan:    "4fc558225913b629b144661385841e63ebb167beb9900475fadb0c0e886b4997"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de7d82b64115f1e9f84b6bdcedf8d2bbff7730092d6f8df50e3c4613b0224608" # linuxbrew-core
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    input = <<~EOS
      w"hello wurld"
      s+7
      r-4
      w"orld"
      q
    EOS
    pipe_output("#{bin}/ired test.text", input)
    assert_equal "hello world", (testpath/"test.text").read.chomp
  end
end
