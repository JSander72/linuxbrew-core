class Hostess < Formula
  desc "Idempotent command-line utility for managing your /etc/hosts file"
  homepage "https://github.com/cbednarski/hostess"
  url "https://github.com/cbednarski/hostess/archive/v0.5.2.tar.gz"
  sha256 "ece52d72e9e886e5cc877379b94c7d8fe6ba5e22ab823ef41b66015e5326da87"
  license "MIT"
  head "https://github.com/cbednarski/hostess.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4272e75f8cba2d02e038dca00f7620a70ca396f3486aaf57a6a9fde77645c562"
    sha256 cellar: :any_skip_relocation, big_sur:       "addb5bc6b7ff84ad6d2a33f2e0c46298f16865473ad82a32c02434def068c26b"
    sha256 cellar: :any_skip_relocation, catalina:      "9386f4841bb16ea44d5131b0a360138a3d33d7595e85d0baba3b9546762d7ae6"
    sha256 cellar: :any_skip_relocation, mojave:        "90e6b36f4131f2e8a914cd81e6a17e59075e734fa83b583654e178c6e7e65aa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d877db59a78cefae8f14353af9cb5b779159318c09ff77f2b4853e188ace138b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w -X main.version=#{version}"
  end

  test do
    assert_match "localhost", shell_output("#{bin}/hostess ls 2>&1")
  end
end
