class Gx < Formula
  desc "Language-agnostic, universal package manager"
  homepage "https://github.com/whyrusleeping/gx"
  url "https://github.com/whyrusleeping/gx/archive/v0.14.3.tar.gz"
  sha256 "2c0b90ddfd3152863f815c35b37e94d027216c6ba1c6653a94b722bf6e2b015d"
  license "MIT"
  head "https://github.com/whyrusleeping/gx.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7099419ae5d6da42d66de65b1a4b9355f586f7484a6a738d1caa1c77ff917670"
    sha256 cellar: :any_skip_relocation, big_sur:       "5171470b8fe21652a1ae5fef81f0b463a3c10fdac821134f2e8d7635af1ccdda"
    sha256 cellar: :any_skip_relocation, catalina:      "f737f5829c0e1ce2ff58c56515e77f3797c30d614a53ebbf663985d5564c62db"
    sha256 cellar: :any_skip_relocation, mojave:        "bd03f428c3e52561caefaa09c6abc92b21faa226ad02abeeb6c74217ca1dfbbf"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e6634c1b68abcb48984a7d681248393ca26824a81496c567ef23029ff9a892f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2bb95886ac055c55d980e3ac8bb4b080da5fd24ece8d63eb74b68cfd450ac835" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"gx"
  end

  test do
    assert_match "ERROR: no package found in this directory or any above", shell_output("#{bin}/gx deps", 1)
  end
end
