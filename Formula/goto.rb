class Goto < Formula
  desc "Bash tool for navigation to aliased directories with auto-completion"
  homepage "https://github.com/iridakos/goto"
  url "https://github.com/iridakos/goto/archive/v2.0.0.tar.gz"
  sha256 "460fe3994455501b50b2f771f999ace77ade295122e90e959084047dbfb1f0dc"
  license "MIT"

  def install
    bash_completion.install "goto.sh"
  end

  test do
    output = shell_output("source #{bash_completion}/goto.sh && complete -p goto")
    assert_match "-F _complete_goto_bash", output
  end
end
