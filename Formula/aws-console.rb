class AwsConsole < Formula
  desc "Command-line to use AWS CLI credentials to launch the AWS console in a browser"
  homepage "https://github.com/aws-cloudformation/rain"
  url "https://github.com/aws-cloudformation/rain/archive/v1.2.0.tar.gz"
  sha256 "064bc2b563c9b759d16147f33fe5c64bf0af3640cb4ae543e49615ae17b22e01"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cad10ed651e199a6ca16f3aed1a4ba7b78e29f7924af2e3b7fef9b88a3429ee8"
    sha256 cellar: :any_skip_relocation, big_sur:       "2268358c33a9f5bc64a9e0dade281df98a6a9b0b9669f8d84ec41da7a0731a10"
    sha256 cellar: :any_skip_relocation, catalina:      "33f94ef8581875ef09f33d6b9fdd619cf46be7d9fa90c62e3b9f4be73122715d"
    sha256 cellar: :any_skip_relocation, mojave:        "62a9e705d060804542509742dc907ec59359c5e6c45ce24b33f1ba3851150270"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b33ff500e53d8904f149add2b35ee532f4297028cd1f65de7a7cfec1121193de" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "cmd/aws-console/main.go"
  end

  test do
    # No other operation is possible without valid AWS credentials configured
    output = shell_output("#{bin}/aws-console 2>&1", 1)
    assert_match "could not establish AWS credentials; please run 'aws configure' or choose a profile", output
  end
end
