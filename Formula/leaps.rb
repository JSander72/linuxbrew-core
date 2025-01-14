class Leaps < Formula
  desc "Collaborative web-based text editing service written in Golang"
  homepage "https://github.com/jeffail/leaps"
  url "https://github.com/Jeffail/leaps/archive/v0.9.1.tar.gz"
  sha256 "8335e2a939ac5928a05f71df4014529b5b0f2097152017d691a0fb6d5ae27be4"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2602cc2c500cc446b5ceb72ffbb6dab1d339ffda72b5be20c73e33a432378e3e"
    sha256 cellar: :any_skip_relocation, big_sur:       "8ed65478fa14879ff6c24e7e6710d09a8143fe33aad4f8f353bb4ab91e393824"
    sha256 cellar: :any_skip_relocation, catalina:      "3b5cbe1f1da86d1cf1a3603fd6b0697a8fbe3bdffe6083dfc5b16c60cb5c3798"
    sha256 cellar: :any_skip_relocation, mojave:        "1f777329b3f9c45a8d94ad10af2183067ca6d28c8f5db48d6c26d33e7d381961"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7dbc71cea9d44ca6d40390faf80ee4243f0157d1b0db29ba153bf0195b8a8e19" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w", "./cmd/leaps"
  end

  test do
    port = ":#{free_port}"

    # Start the server in a fork
    leaps_pid = fork do
      exec "#{bin}/leaps", "-address", port
    end

    # Give the server some time to start serving
    sleep(1)

    # Check that the server is responding correctly
    assert_match "You are alone", shell_output("curl -o- http://localhost#{port}")
  ensure
    # Stop the server gracefully
    Process.kill("HUP", leaps_pid)
  end
end
