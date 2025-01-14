class GithubRelease < Formula
  desc "Create and edit releases on Github (and upload artifacts)"
  homepage "https://github.com/github-release/github-release"
  url "https://github.com/github-release/github-release/archive/v0.10.0.tar.gz"
  sha256 "79bfaa465f549a08c781f134b1533f05b02f433e7672fbaad4e1764e4a33f18a"
  license "MIT"
  head "https://github.com/github-release/github-release.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "dfaa0f4ae21d44b1e0716ef71cabf02ac60a8692893b2a49bb32e096cb441a4a"
    sha256 cellar: :any_skip_relocation, big_sur:       "d7770942546f2a49c7b44104fe69ad7cf724cc1eac39280d1217af66ccd97e3b"
    sha256 cellar: :any_skip_relocation, catalina:      "6dc8bf5543967949480fb9bf3f24e149a5ef52857cc38877125f9ad6281eeb58"
    sha256 cellar: :any_skip_relocation, mojave:        "745fcc9458243936c5e482098357c5f83d44e5126e5346f1f6c6ca90ee55a4c6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "06610102485cb214158fa30123d9584508f29c683be05d4f7298401f7fa171fd" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    system "make"
    bin.install "github-release"
  end

  test do
    system "#{bin}/github-release", "info", "--user", "github-release",
                                            "--repo", "github-release",
                                            "--tag", "v#{version}"
  end
end
