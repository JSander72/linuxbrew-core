class Snap < Formula
  desc "Tool to work with .snap files"
  homepage "https://snapcraft.io/"
  url "https://github.com/snapcore/snapd/releases/download/2.46/snapd_2.46.vendor.tar.xz"
  version "2.46"
  sha256 "c4f532018ca9d2a5f87a95909b3674f8e299e97ba5cb5575895bcdd29be23db3"
  license "GPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "736643f2e11f651d081b6515f04127c3bca06afb4b86734436d45534abead197"
    sha256 cellar: :any_skip_relocation, big_sur:       "9cb1d7db5a7f7854fecedf029d130977238a0ed9a8a32a4454225712d3542878"
    sha256 cellar: :any_skip_relocation, catalina:      "f60a56adf86fdc4c86b5d38b47f21c52e0459612c9ed7ae15905a4c838e51787"
    sha256 cellar: :any_skip_relocation, mojave:        "febbdc8548096fb9d0159c8b7cbaa4281ba8b868625264b254aab3ce4d2b7924"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5862112321dc8a50e0543f3af76d93f9f30b0de30a8b32fb12b496decefe2ead" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "squashfs"

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    (buildpath/"src/github.com/snapcore/snapd").install buildpath.children

    cd "src/github.com/snapcore/snapd" do
      system "./mkversion.sh", version
      system "go", "build", *std_go_args, "./cmd/snap"

      bash_completion.install "data/completion/bash/snap"
      zsh_completion.install "data/completion/zsh/_snap"

      (man8/"snap.8").write Utils.safe_popen_read("#{bin}/snap", "help", "--man")
    end
  end

  test do
    (testpath/"pkg/meta").mkpath
    (testpath/"pkg/meta/snap.yaml").write <<~EOS
      name: test-snap
      version: 1.0.0
      summary: simple summary
      description: short description
    EOS
    system "#{bin}/snap", "pack", "pkg"
    system "#{bin}/snap", "version"
  end
end
