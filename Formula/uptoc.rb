class Uptoc < Formula
  desc "Convenient static file deployment tool that supports multiple platforms"
  homepage "https://github.com/saltbo/uptoc"
  url "https://github.com/saltbo/uptoc.git",
      tag:      "v1.4.3",
      revision: "30266b490379c816fc08ca3670fd96808214b24c"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7e6500f982ce6d54888461d97c8bad6dda039d065e883a60047ca549d9e06329"
    sha256 cellar: :any_skip_relocation, big_sur:       "40353c235e30210ab737684f85d6c444b580192eccbf50d84fbae0fa8a64c27b"
    sha256 cellar: :any_skip_relocation, catalina:      "7a2f3982a14ad4176b17832e87dfb2a41fd10d87e0e35ade341b8baa17d3b7ab"
    sha256 cellar: :any_skip_relocation, mojave:        "bd9cc58bd67f536070d5c34cd10733ba9744cfffc8aa3ef74b2ab6d558c32c2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b0d4188b0faa070c47654e306a3c201f6048a2c688416b299072a6625a7336cc" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags",
      "-s -w -X main.release=#{version} -X main.commit=#{Utils.git_head} -X main.repo=#{stable.url}",
      *std_go_args,
      "./cmd"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uptoc -v 2>&1")
    assert_match "uptoc config", shell_output("#{bin}/uptoc ./abc 2>&1", 1)
  end
end
