class Karn < Formula
  desc "Manage multiple Git identities"
  homepage "https://github.com/prydonius/karn"
  url "https://github.com/prydonius/karn/archive/v0.0.5.tar.gz"
  sha256 "bb3e6d93a4202cde22f8ea0767c994dfebd018fba1f4c1876bf9ab0e765aa45c"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9fff2a71abf62d3eaedba7d095e3fcfd9fbaa17895dab15fabefc4cd2d5a8725"
    sha256 cellar: :any_skip_relocation, big_sur:       "bdcf0389352b56c208549750ec502a1bfc01c02c0466c981abfcace027cc479b"
    sha256 cellar: :any_skip_relocation, catalina:      "6f9d3e100d55f950b54ee3ada80008209a1f61aefe62ae7f171e9615554b2f93"
    sha256 cellar: :any_skip_relocation, mojave:        "4d676e8bc136599f4ec3ef0d6cb604b003ced4a0537c190ea430d5b0ca8609cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7f89604d20a95f5f330463e56dfa86d920238bc00c7cb5ced040f86c81570c26" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w", "./cmd/karn/karn.go"
  end

  test do
    (testpath/".karn.yml").write <<~EOS
      ---
      #{testpath}:
        name: Homebrew Test
        email: test@brew.sh
    EOS
    system "git", "init"
    system "git", "config", "--global", "user.name", "Test"
    system "git", "config", "--global", "user.email", "test@test.com"
    system "#{bin}/karn", "update"
  end
end
