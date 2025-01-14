class Jvgrep < Formula
  desc "Grep for Japanese users of Vim"
  homepage "https://github.com/mattn/jvgrep"
  url "https://github.com/mattn/jvgrep/archive/v5.8.9.tar.gz"
  sha256 "37e1b9aa4571f98a102b4f7322d7f581c608c0fcd50542dfaa7af742184fb1dc"
  license "MIT"
  head "https://github.com/mattn/jvgrep.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a9f22b7d0972294f7d6d1dec7f88628df527656aad3e3f5331da3b16d78928cb"
    sha256 cellar: :any_skip_relocation, big_sur:       "d7d7ed4778bab36afa71a8b06b5a42b5d4178bb3bd08c94a90e9f099af5ea92e"
    sha256 cellar: :any_skip_relocation, catalina:      "da1235bed154594ddbda2614b02a42cefe359aeb02835bd99cce97642aa83df7"
    sha256 cellar: :any_skip_relocation, mojave:        "dde02ed909386bfbbd045fb7c6109544a7e7f3f047b0add74d2ace9ff1fa5d62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "445e2bd02e005dc839548ab12c5500507a78c687d07e51cb2d8971b01c94f2b2" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"Hello.txt").write("Hello World!")
    system bin/"jvgrep", "Hello World!", testpath
  end
end
