class Kind < Formula
  desc "Run local Kubernetes cluster in Docker"
  homepage "https://kind.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/kind/archive/v0.11.1.tar.gz"
  sha256 "95ce0e7b01c00be149e5bd777936cef3f79ba7f1f3e5872e7ed60595858a2491"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/kind.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "29920822e416eea3f363200b64666756a2979aa186e067b3794bb5466aeaaf35"
    sha256 cellar: :any_skip_relocation, big_sur:       "116a1749c6aee8ad7282caf3a3d2616d11e6193c839c8797cde045cddd0e1138"
    sha256 cellar: :any_skip_relocation, catalina:      "15aa1527c8886da5ce345ae84f255fd33ee9726acef8c6ba1f33c2f5af8d6a96"
    sha256 cellar: :any_skip_relocation, mojave:        "f506e71e34e0e43f48425a733b77d4f7f574861d52041d6c3a8a7220ae49943f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc95e3a9414bcb9ace9eba0f46a1796080f7bd50f4eedabaea016cae05611398" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "docker" => :test

  def install
    system "go", "build", *std_go_args

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/kind", "completion", "bash")
    (bash_completion/"kind").write output

    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/kind", "completion", "zsh")
    (zsh_completion/"_kind").write output

    # Install fish completion
    output = Utils.safe_popen_read("#{bin}/kind", "completion", "fish")
    (fish_completion/"kind.fish").write output
  end

  test do
    ENV["DOCKER_HOST"] = "unix://#{testpath}/invalid.sock"

    # Should error out as creating a kind cluster requires root
    status_output = shell_output("#{bin}/kind get kubeconfig --name homebrew 2>&1", 1)
    assert_match "Cannot connect to the Docker daemon", status_output
  end
end
