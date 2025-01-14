class Glide < Formula
  desc "Simplified Go project management, dependency management, and vendoring"
  homepage "https://github.com/Masterminds/glide"
  url "https://github.com/Masterminds/glide/archive/v0.13.3.tar.gz"
  sha256 "817dad2f25303d835789c889bf2fac5e141ad2442b9f75da7b164650f0de3fee"
  license "MIT"
  head "https://github.com/Masterminds/glide.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "77ff52f69bde39ac4ba11eec08cc4c7ef5fab166ab801f513486d0a62e448ead"
    sha256 cellar: :any_skip_relocation, big_sur:       "33a39604d9007bf46e92a0a9131a59c15162dce6ace8b498a91110bc7d316f43"
    sha256 cellar: :any_skip_relocation, catalina:      "014fc42198c07253f844ea7b20b1a9378b08cfb445e548b307c6fb131bd44565"
    sha256 cellar: :any_skip_relocation, mojave:        "7f4be1018eba40d85aca555364a09f97a18d8e09c71e6bb42e6ca1a2c0866865"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad6e9703f508da34c1f44fde18dcd00e5106a4bc4cc02a967e64c10e9273c943" # linuxbrew-core
  end

  # See: https://github.com/Masterminds/glide/commit/c64b14592409a83052f7735a01d203ff1bab0983
  deprecate! date: "2021-01-02", because: :deprecated_upstream

  depends_on "go"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    glidepath = buildpath/"src/github.com/Masterminds/glide"
    glidepath.install buildpath.children

    cd glidepath do
      system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/glide --version")
    system bin/"glide", "create", "--non-interactive", "--skip-import"
    assert_predicate testpath/"glide.yaml", :exist?
  end
end
