class Rain < Formula
  desc "Command-line tool for working with AWS CloudFormation"
  homepage "https://github.com/aws-cloudformation/rain"
  url "https://github.com/aws-cloudformation/rain/archive/v1.2.0.tar.gz"
  sha256 "064bc2b563c9b759d16147f33fe5c64bf0af3640cb4ae543e49615ae17b22e01"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9d734401c46693b663ebb1f7cc070f13b5685a8699a02a92e8c24a61b3f5b367"
    sha256 cellar: :any_skip_relocation, big_sur:       "5f81d8ad4b04cc8fa7d5594e65fcbc60fe706fa5509bd91baf006d68e252cda9"
    sha256 cellar: :any_skip_relocation, catalina:      "0f7c618e299a493540330c769eea29de70086ecd71fb904b1d5dd89a5535dee7"
    sha256 cellar: :any_skip_relocation, mojave:        "ca9c4253ee251bc3b5ecf07b6c2c9e792d987072e736cf85141314d03a8d463b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "729fb5e12969f20bc66285be4d1e7c1dba9e13ba758fa41ef3689793272ee043" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "cmd/rain/main.go"
    bash_completion.install "docs/bash_completion.sh"
    zsh_completion.install "docs/zsh_completion.sh"
  end

  def caveats
    <<~EOS
      Deploying CloudFormation stacks with rain requires the AWS CLI to be installed.
      All other functionality works without the AWS CLI.
    EOS
  end

  test do
    (testpath/"test.template").write <<~EOS
      Resources:
        Bucket:
          Type: AWS::S3::Bucket
    EOS
    assert_equal "test.template: formatted OK", shell_output("#{bin}/rain fmt -v test.template").strip
  end
end
