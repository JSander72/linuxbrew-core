class GitFlow < Formula
  desc "Extensions to follow Vincent Driessen's branching model"
  homepage "https://github.com/nvie/gitflow"
  license "BSD-2-Clause"

  stable do
    # Use the tag instead of the tarball to get submodules
    url "https://github.com/nvie/gitflow.git",
        tag:      "0.4.1",
        revision: "1ffb6b1091f05466d3cd27f2da9c532a38586ed5"

    resource "completion" do
      url "https://github.com/bobthecow/git-flow-completion/archive/0.4.2.2.tar.gz"
      sha256 "1e82d039596c0e73bfc8c59d945ded34e4fce777d9b9bb45c3586ee539048ab9"
    end
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7da4f3bb9c8cf3678057b79f03c056b1848aea64d16d4be68621a14352ca5477"
    sha256 cellar: :any_skip_relocation, big_sur:       "46009ab147b52d74bbda2a0b4d97374f0e515a5157db4ff803f6270ded7fde48"
    sha256 cellar: :any_skip_relocation, catalina:      "8ea12cd7e2666fb6fdfaffaeb3a0437037a40cde559a835fc9de038f36a424dc"
    sha256 cellar: :any_skip_relocation, mojave:        "ab455769b6b8122e1d345f56d799fe43445bbbeba6265892715167388c737af9"
    sha256 cellar: :any_skip_relocation, high_sierra:   "ce4b64f4d13f4a5a8e05c9087627b42cd328c8accc8349c4ca256238d1d3fecc"
    sha256 cellar: :any_skip_relocation, sierra:        "acb9a2690fa86925600fa6e67e38731ef05f7f5d6ccfceb9c5175286c1081fe0"
    sha256 cellar: :any_skip_relocation, el_capitan:    "56826b30d91ffb54829f4792f88c673b1c3e748aa662bef5806e4a6f5d0ee015"
    sha256 cellar: :any_skip_relocation, yosemite:      "a5e97d4d5c082194b36c18e7b051c43b2d5b37366b2ac56c5ea9407f6315685b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae350c42764f62938a932b475f71c37eb75db4c884b7e14642e55fd467fac494" # linuxbrew-core
  end

  head do
    url "https://github.com/nvie/gitflow.git", branch: "develop"

    resource "completion" do
      url "https://github.com/bobthecow/git-flow-completion.git", branch: "develop"
    end
  end

  conflicts_with "git-flow-avh", because: "both install `git-flow` binaries and completions"

  def install
    system "make", "prefix=#{libexec}", "install"
    bin.write_exec_script libexec/"bin/git-flow"

    resource("completion").stage do
      bash_completion.install "git-flow-completion.bash"
      zsh_completion.install "git-flow-completion.zsh"
    end
  end

  test do
    system "git", "flow", "init", "-d"
    assert_equal "develop", shell_output("git rev-parse --abbrev-ref HEAD").strip
  end
end
