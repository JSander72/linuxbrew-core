class Fetch < Formula
  desc "Download assets from a commit, branch, or tag of GitHub repositories"
  homepage "https://www.gruntwork.io/"
  url "https://github.com/gruntwork-io/fetch/archive/v0.4.2.tar.gz"
  sha256 "b8ba80823e961fd2761ef2d855d308b69313930e0ffd445e34840a2ef9b4c6fb"
  license "MIT"
  head "https://github.com/gruntwork-io/fetch.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dad3c162a7e7856f05418531b52e57b637f2c996c41a471eb8b8fadd4aec0770"
    sha256 cellar: :any_skip_relocation, big_sur:       "85cdfcf652c09182573850736a47b509dee83710c6fba83f6e36d58ea04c0257"
    sha256 cellar: :any_skip_relocation, catalina:      "1c753e963f8cf9b1b9ea7af0a056fcc7e9f88246894a51865c115d1e3991b03d"
    sha256 cellar: :any_skip_relocation, mojave:        "2acd0666bf17c0e50b7324647dae8b46c2e35360e37e15733487d2c72e66aacf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db5cf518615bfa77acc7bc6765a9432e59ee6623befcff3767acd8c3c1b881f6" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.VERSION=v#{version}", *std_go_args
  end

  test do
    repo_url = "https://github.com/gruntwork-io/fetch"

    assert_match "Downloading release asset SHA256SUMS to SHA256SUMS",
      shell_output("#{bin}/fetch --repo=\"#{repo_url}\" --tag=\"v0.3.10\" --release-asset=\"SHA256SUMS\" . 2>&1")
  end
end
