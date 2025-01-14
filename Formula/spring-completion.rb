class SpringCompletion < Formula
  desc "Bash completion for Spring"
  homepage "https://github.com/jacaetevha/spring_bash_completion"
  url "https://github.com/jacaetevha/spring_bash_completion/archive/v0.0.1.tar.gz"
  sha256 "a97b256dbdaca894dfa22bd96a6705ebf4f94fa8206d05f41927f062c3dd60bf"
  license "Unlicense"
  head "https://github.com/jacaetevha/spring_bash_completion.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5c188dbaccd58b79b5596c7d0c34cd3a1a997cea7f6131393b11205a77964c2a"
    sha256 cellar: :any_skip_relocation, big_sur:       "1110b2611a3d8dc08fe1731e46692b9d77234e60aba14602f0ad1f9380933eeb"
    sha256 cellar: :any_skip_relocation, catalina:      "1110b2611a3d8dc08fe1731e46692b9d77234e60aba14602f0ad1f9380933eeb"
    sha256 cellar: :any_skip_relocation, mojave:        "1110b2611a3d8dc08fe1731e46692b9d77234e60aba14602f0ad1f9380933eeb"
  end

  def install
    bash_completion.install "spring.bash" => "spring"
  end

  test do
    assert_match "-F _spring",
      shell_output("source #{bash_completion}/spring && complete -p spring")
  end
end
