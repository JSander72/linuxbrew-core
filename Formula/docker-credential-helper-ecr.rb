class DockerCredentialHelperEcr < Formula
  desc "Docker Credential Helper for Amazon ECR"
  homepage "https://github.com/awslabs/amazon-ecr-credential-helper"
  url "https://github.com/awslabs/amazon-ecr-credential-helper.git",
      tag:      "v0.5.0",
      revision: "b19192b6522b2da02d14ec394c331f3b1a70efe2"
  license "Apache-2.0"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0f76feceea1f591784fb2bb273950336675228c1d9e04d91af48d9bc6b700ddb"
    sha256 cellar: :any_skip_relocation, big_sur:       "822e7f36e21c109c0228fd53858781f872a4176a712b591a775c38769edc5189"
    sha256 cellar: :any_skip_relocation, catalina:      "8506b1954205b0ccc6622738219606deb595da298797455442f5e7590886a1d8"
    sha256 cellar: :any_skip_relocation, mojave:        "ade7af932bef1787cd560cb2befcd2ce9dcaa4ee694cac37dbf4a86265186667"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c5345f78dab1aa15d2df6fcd6d96139235e5d7fcaae0f6966d8c7c6aa39b009" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/awslabs/amazon-ecr-credential-helper"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      system "make", "build"
      bin.install "bin/local/docker-credential-ecr-login"
      prefix.install_metafiles
    end
  end

  test do
    output = shell_output("#{bin}/docker-credential-ecr-login", 1)
    assert_match %r{^Usage: .*/docker-credential-ecr-login.*}, output
  end
end
