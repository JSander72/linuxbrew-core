class Fex < Formula
  desc "Powerful field extraction tool"
  homepage "https://www.semicomplete.com/projects/fex/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/semicomplete/fex-2.0.0.tar.gz"
  sha256 "03043c8eac74f43173068a2e693b6f73d5b45f453a063e6da11f34455d0e374e"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bb8ef2d1b057c6cc2c462f6398911d8f55a85398b6eaf60f26c01a7cb3f87e04"
    sha256 cellar: :any_skip_relocation, big_sur:       "48289f9a071052a99a7ff520feb793abe0cfd3c81b939bf767cc3bb51ac09918"
    sha256 cellar: :any_skip_relocation, catalina:      "ddc12a1eefc9238e48ba57f00694e6b01cdce2ef41bcf34ddfd405696d3a7a65"
    sha256 cellar: :any_skip_relocation, mojave:        "c3daa86f0f51e3bd7be8cd890a46bd2a50e6a0fb728f664ce1847edb6b5f7f0c"
    sha256 cellar: :any_skip_relocation, high_sierra:   "1b293789f75a67d36037f9d80641814119c8f4534a78dbf321744276a41f2c15"
    sha256 cellar: :any_skip_relocation, sierra:        "e42328824017f1432ace562fdd70061e504c5524d2702f3d4b470c40b1bf105e"
    sha256 cellar: :any_skip_relocation, el_capitan:    "952c166ae7efc5c7955bba3c54fefc1e5c18fe2296804b15554a8703285034e1"
    sha256 cellar: :any_skip_relocation, yosemite:      "2c20c6bf653b60b290d6e08aee9aaa46475754cfd61680e312d46678ea9a1f4c"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_equal "foo", pipe_output("#{bin}/fex 1", "foo bar", 0).chomp
  end
end
