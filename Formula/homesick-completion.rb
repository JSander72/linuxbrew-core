class HomesickCompletion < Formula
  desc "Bash completion for Homesick"
  homepage "https://github.com/JoeNyland/homesick-completion"
  url "https://github.com/JoeNyland/homesick-completion/archive/v1.0.0.tar.gz"
  sha256 "f9953d92dc5c0d9770d502a68651795c78f5d7bd6078cd747e77ebc602c43609"
  license "MIT"

  deprecate! date: "2020-08-10", because: :repo_archived

  def install
    bash_completion.install "homesick"
  end

  test do
    assert_match "-F _homesick",
      shell_output("source #{bash_completion}/homesick && complete -p homesick")
  end
end
