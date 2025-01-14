class DockerMachineCompletion < Formula
  desc "Completion script for docker-machine"
  homepage "https://docs.docker.com/machine/completion/"
  url "https://github.com/docker/machine/archive/v0.16.2.tar.gz"
  sha256 "af8bff768cd1746c787e2f118a3a8af45ed11679404b6e45d5199e343e550059"
  license "Apache-2.0"
  head "https://github.com/docker/machine.git"

  bottle do
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6bf2154616b12163c1f64966eb5937e2a1ecd6a4da1cd1e69dcb24cd2eab69a3" # linuxbrew-core
  end

  conflicts_with "docker-machine",
    because: "docker-machine already includes completion scripts"

  def install
    bash_completion.install Dir["contrib/completion/bash/*.bash"]
    zsh_completion.install "contrib/completion/zsh/_docker-machine"
  end

  test do
    assert_match "-F _docker_machine",
      shell_output("bash -O extglob -c 'source #{bash_completion}/docker-machine.bash && complete -p docker-machine'")
  end
end
