class Glow < Formula
  desc "Render markdown on the CLI"
  homepage "https://github.com/charmbracelet/glow"
  url "https://github.com/charmbracelet/glow/archive/v1.4.1.tar.gz"
  sha256 "ff6dfd7568f0bac5144ffa3a429ed956dcbdb531487ef6e38ac61365322c9601"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c7e15ba449c8f2720d93f8bde3f80fa3e27c82cf5bacc2944114ec4650a25d45"
    sha256 cellar: :any_skip_relocation, big_sur:       "c76069ff642658ed8b51fd903b1a5a5892247de72f7f62f29e10d46cae3e6caf"
    sha256 cellar: :any_skip_relocation, catalina:      "4e713fa69e7d61139e8e7f904c675d2bfbabba9977316c22b4868f3bf5e0c77e"
    sha256 cellar: :any_skip_relocation, mojave:        "22926fb845a37fd3dd9bee91e5af5575204480c5dfa2a6826cdb70fed07a80d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f737dcded65ba0209e7a4512bd4cad9dc78e236bafc479e4e17531c742a81680" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w -X main.Version=#{version}", "-trimpath", "-o", bin/name
  end

  test do
    (testpath/"test.md").write <<~EOS
      # header

      **bold**

      ```
      code
      ```
    EOS
    assert_match "# header", shell_output("#{bin}/glow test.md")
  end
end
