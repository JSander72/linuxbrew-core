class Desk < Formula
  desc "Lightweight workspace manager for the shell"
  homepage "https://github.com/jamesob/desk"
  url "https://github.com/jamesob/desk/archive/v0.6.0.tar.gz"
  sha256 "620bfba5b285d4d445e3ff9e399864063d7b0e500ef9c70d887fb7b157576c45"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "584bb3f6a1891f3f2d3dca6c96df0643bf22be40544907c4338baaf07902821c" # linuxbrew-core
  end

  def install
    bin.install "desk"
    bash_completion.install "shell_plugins/bash/desk"
    zsh_completion.install "shell_plugins/zsh/_desk"
    fish_completion.install "shell_plugins/fish/desk.fish"
  end

  test do
    (testpath/".desk/desks/test-desk.sh").write("#\n# Description: A test desk\n#")
    list = pipe_output("#{bin}/desk list")
    assert_match "test-desk", list
    assert_match "A test desk", list
  end
end
