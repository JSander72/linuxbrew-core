class GitTrim < Formula
  desc "Trim your git remote tracking branches that are merged or gone"
  homepage "https://github.com/foriequal0/git-trim"
  url "https://github.com/foriequal0/git-trim/archive/v0.4.2.tar.gz"
  sha256 "0f728c7f49cc8ffb0c485547a114c94bdebd7eead9466b1b43f486ef583a3d73"
  license "MIT"

  bottle do
    sha256 cellar: :any, big_sur:      "5c52fe8dd74e83a4a7048ae8a4f42661c2738718ea40ebede07ecf83771ba5ff"
    sha256 cellar: :any, catalina:     "387724382d30ce0ac900da57f737d0f3ba91a57e29242e8b790f4ade97bf7179"
    sha256 cellar: :any, mojave:       "090af1343e6b5938c97127d0c7a63fe49804269c0dc0c98c19ed160798b34bec"
    sha256 cellar: :any, high_sierra:  "23beea483f50121bdf7b545e0345ec5d192ee362fcf3402f999905c3ebcd8188"
    sha256 cellar: :any, x86_64_linux: "5780a17e13aa4c635d8cf473cc169048a058009cd5dbc0a18ce48028489ad205" # linuxbrew-core
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  uses_from_macos "zlib"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    system "cargo", "install", *std_cargo_args
    man1.install "docs/git-trim.man" => "git-trim.1"
  end

  test do
    system "git", "clone", "https://github.com/foriequal0/git-trim"
    Dir.chdir("git-trim")
    system "git", "branch", "brew-test"
    assert_match "brew-test", shell_output("git trim")
  end
end
