class YoutubeDl < Formula
  include Language::Python::Virtualenv

  desc "Download YouTube videos from the command-line"
  homepage "https://youtube-dl.org/"
  url "https://files.pythonhosted.org/packages/c6/75/05979677d9abc76851d13d8db3951e39017ac223545adab6e8576fa0cbe7/youtube_dl-2021.6.6.tar.gz"
  sha256 "cb2d3ee002158ede783e97a82c95f3817594df54367ea6a77ce5ceea4772f0ab"
  license "Unlicense"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c8488b8408d6382b7bce6359cc18f7e14ab5f250152f18f69d250fbc6dd4f081"
    sha256 cellar: :any_skip_relocation, big_sur:       "f4c3781a6c30a1da5319e581cac99be7fd533295fa8780ef66c3bf696f755e5f"
    sha256 cellar: :any_skip_relocation, catalina:      "f4c3781a6c30a1da5319e581cac99be7fd533295fa8780ef66c3bf696f755e5f"
    sha256 cellar: :any_skip_relocation, mojave:        "f4c3781a6c30a1da5319e581cac99be7fd533295fa8780ef66c3bf696f755e5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3cbf702120a2d7dee9036d1057ece99fa4c9afa9e5ad07bfb8d6abe31198cb2a" # linuxbrew-core
  end

  depends_on "python@3.9"

  def install
    virtualenv_install_with_resources
    man1.install_symlink libexec/"share/man/man1/youtube-dl.1" => "youtube-dl.1"
    bash_completion.install libexec/"etc/bash_completion.d/youtube-dl.bash-completion"
    fish_completion.install libexec/"etc/fish/completions/youtube-dl.fish"
  end

  test do
    # commit history of homebrew-core repo
    system "#{bin}/youtube-dl", "--simulate", "https://www.youtube.com/watch?v=pOtd1cbOP7k"
    # homebrew playlist
    system "#{bin}/youtube-dl", "--simulate", "--yes-playlist", "https://www.youtube.com/watch?v=pOtd1cbOP7k&list=PLMsZ739TZDoLj9u_nob8jBKSC-mZb0Nhj"
  end
end
