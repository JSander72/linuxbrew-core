class GitAppraise < Formula
  desc "Distributed code review system for Git repos"
  homepage "https://github.com/google/git-appraise"
  url "https://github.com/google/git-appraise/archive/v0.6.tar.gz"
  sha256 "5c674ee7f022cbc36c5889053382dde80b8e80f76f6fac0ba0445ed5313a36f1"
  license "Apache-2.0"
  head "https://github.com/google/git-appraise.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1119799fffe94a2ae103efbd5b3e627ed527c500ffe86d5c817b6954de5d9dbe"
    sha256 cellar: :any_skip_relocation, big_sur:       "0a69bb7443445c01a0c50b331ced29ab21a24b15053b1b3b6619b87508c33a5b"
    sha256 cellar: :any_skip_relocation, catalina:      "2d36acb4d28daabb41a0629e79a11aed722a988bdde30643cd24bc366f69754c"
    sha256 cellar: :any_skip_relocation, mojave:        "f5f69cc84ebca243907d1e735b8f80807f48de36b3d6eea42a8ab99edbd48eb0"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e515979b703cef062e19829399ddb441c91d835e25814614c938af36764fc0d4"
    sha256 cellar: :any_skip_relocation, sierra:        "c048f2cce708e7c85c74d18758e47d3959cce29e2f8e70bca021b1564e65092d"
    sha256 cellar: :any_skip_relocation, el_capitan:    "e12ce185286565f4f07f48f1deb2fd4a19043bcafb337de94b9ba7148291b91b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c32da22cd50d604799065ab2e1a48921d55f78fb2278f5ba78a9b85c86e85229" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    (buildpath/"src/github.com/google").mkpath
    ln_s buildpath, buildpath/"src/github.com/google/git-appraise"

    system "go", "build", "-o", bin/"git-appraise", "github.com/google/git-appraise/git-appraise"
  end

  test do
    system "git", "init"
    system "git", "config", "user.email", "user@email.com"
    (testpath/"README").write "test"
    system "git", "add", "README"
    system "git", "commit", "-m", "Init"
    system "git", "branch", "user/test"
    system "git", "checkout", "user/test"
    (testpath/"README").append_lines "test2"
    system "git", "add", "README"
    system "git", "commit", "-m", "Update"
    system "git", "appraise", "request", "--allow-uncommitted"
    assert_predicate testpath/".git/refs/notes/devtools/reviews", :exist?
  end
end
