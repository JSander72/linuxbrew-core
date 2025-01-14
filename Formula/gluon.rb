class Gluon < Formula
  desc "Static, type inferred and embeddable language written in Rust"
  homepage "https://gluon-lang.org"
  url "https://github.com/gluon-lang/gluon/archive/v0.17.2.tar.gz"
  sha256 "8fc8cc2211cff7a3d37a64c0b1f0901767725d3c2c26535cb9aabbfe921ba18e"
  license "MIT"
  head "https://github.com/gluon-lang/gluon.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "62a081e09aff7da0df608c4b9c7a852e75c2226d5953bc0a938af6fb716b793e"
    sha256 cellar: :any_skip_relocation, big_sur:       "4c46d2aa89cd80b3fd135f8160019076bc0f01a208a561ef63d84e7959a5d64e"
    sha256 cellar: :any_skip_relocation, catalina:      "abea6a7007ec7663a5d3d8994a8028412843d45210b5b17723f2bcb0dc43134b"
    sha256 cellar: :any_skip_relocation, mojave:        "b6a865cd7da1a201a008ae65478191082501e1dc9ab7b6dae189e4f2f2bef8e4"
    sha256 cellar: :any_skip_relocation, high_sierra:   "847b61a0a4b7d4afc4598301c5bbf6afac3e70c737cdb0a26ad0438db42b1e44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08580a9a5c430e40e64d2e3c5b3e1f3159bbe21c8f28e96c9a2b5fb34afaf2df" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    cd "repl" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    (testpath/"test.glu").write <<~EOS
      let io = import! std.io
      io.print "Hello world!\\n"
    EOS
    assert_equal "Hello world!\n", shell_output("#{bin}/gluon test.glu")
  end
end
