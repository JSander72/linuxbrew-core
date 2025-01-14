class TerraformAT012 < Formula
  desc "Tool to build, change, and version infrastructure"
  homepage "https://www.terraform.io/"
  url "https://github.com/hashicorp/terraform/archive/v0.12.31.tar.gz"
  sha256 "f53aef1f1ea9d72a30145f0018cc16fea076ae09bd93faa320645af7bce3bf4d"
  license "MPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "46b7341d0710f40ec6532bf16de55226e1df553408e99a97dce9aaa668efac27"
    sha256 cellar: :any_skip_relocation, big_sur:       "bcbadc631d4a94c210c5d2b7a82120dee050f6263abc8d2cda78eb5ad0c2cfc5"
    sha256 cellar: :any_skip_relocation, catalina:      "bcbadc631d4a94c210c5d2b7a82120dee050f6263abc8d2cda78eb5ad0c2cfc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f24638c79c95fe4a8d5e4ae7a8fc20bdf470786afaf39dcf384e1f1e9d7375a4" # linuxbrew-core
  end

  keg_only :versioned_formula

  deprecate! date: "2021-04-14", because: :unsupported

  depends_on "go" => :build
  depends_on macos: :catalina

  def install
    # v0.6.12 - source contains tests which fail if these environment variables are set locally.
    ENV.delete "AWS_ACCESS_KEY"
    ENV.delete "AWS_SECRET_KEY"

    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args,
      "-ldflags", "-s -w", "-mod=vendor", "-o", bin/"terraform"
  end

  test do
    minimal = testpath/"minimal.tf"
    minimal.write <<~EOS
      variable "aws_region" {
        default = "us-west-2"
      }

      variable "aws_amis" {
        default = {
          eu-west-1 = "ami-b1cf19c6"
          us-east-1 = "ami-de7ab6b6"
          us-west-1 = "ami-3f75767a"
          us-west-2 = "ami-21f78e11"
        }
      }

      # Specify the provider and access details
      provider "aws" {
        access_key = "this_is_a_fake_access"
        secret_key = "this_is_a_fake_secret"
        region     = var.aws_region
      }

      resource "aws_instance" "web" {
        instance_type = "m1.small"
        ami           = var.aws_amis[var.aws_region]
        count         = 4
      }
    EOS
    system "#{bin}/terraform", "init"
    system "#{bin}/terraform", "graph"
  end
end
