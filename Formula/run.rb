class Run < Formula
  desc "Easily manage and invoke small scripts and wrappers"
  homepage "https://github.com/TekWizely/run"
  url "https://github.com/TekWizely/run/archive/v0.7.2.tar.gz"
  sha256 "c542b523c67e3cd2ca05a8e2f92cca607181a68518b2568a68b76ed9f700d6e0"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "32fff2fd9c8b242912438be13118185afaa20bccad7bb134788ffcc07b66791d"
    sha256 cellar: :any_skip_relocation, big_sur:       "0beed1b3bd5d70f9a8a270a7996d0f309f2cab7cf622556b5d833f8311b8cf7a"
    sha256 cellar: :any_skip_relocation, catalina:      "4a2329ae36f59ed71c1b6364828c465a27f92506cd77e9a7c8217def3e2b7c9e"
    sha256 cellar: :any_skip_relocation, mojave:        "4a2329ae36f59ed71c1b6364828c465a27f92506cd77e9a7c8217def3e2b7c9e"
    sha256 cellar: :any_skip_relocation, high_sierra:   "4a2329ae36f59ed71c1b6364828c465a27f92506cd77e9a7c8217def3e2b7c9e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9fb77719822989beec92148b81ddb2cd6e6f78dc270ffb51fec869915eae2763" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-ldflags", "-w -s", "-o", bin/name
  end

  test do
    text = "Hello Homebrew!"
    task = "hello"
    (testpath/"Runfile").write <<~EOS
      #{task}:
        echo #{text}
    EOS
    assert_equal text, shell_output("#{bin}/#{name} #{task}").chomp
  end
end
