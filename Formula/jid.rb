class Jid < Formula
  desc "Json incremental digger"
  homepage "https://github.com/simeji/jid"
  url "https://github.com/simeji/jid/archive/v0.7.6.tar.gz"
  sha256 "0912050b3be3760804afaf7ecd6b42bfe79e7160066587fbc0afa5324b03fb48"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "37f25dc38d57a971fb609224c33802bfa4213b58d825b188a67eb653af1c9e2f"
    sha256 cellar: :any_skip_relocation, big_sur:       "703bee89d514891dec82186680f2ee9837b1599721c3d68405fd4c72d015a811"
    sha256 cellar: :any_skip_relocation, catalina:      "0b45fe9c59facbc6b2bbacf4b52927934b09d6e2050ad3a5b5a32434a4bd4751"
    sha256 cellar: :any_skip_relocation, mojave:        "2980bf16f4376b7bdfc27e0e6bbe45d9e1f8aca8a143f6f7b6fd939eb6892617"
    sha256 cellar: :any_skip_relocation, high_sierra:   "d429ac5400fd67dcee12e5fe962e84f535858c7ecb3235ee01f8a54dc44e7a9e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8fda694c17d6e1186fa50416922349cb02032332e27e623c0504260da5dce2b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-trimpath", "-o", bin/"jid", "cmd/jid/jid.go"
    prefix.install_metafiles
  end

  test do
    assert_match "jid version v#{version}", shell_output("#{bin}/jid --version")
  end
end
