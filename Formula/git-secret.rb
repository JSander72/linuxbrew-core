class GitSecret < Formula
  desc "Bash-tool to store the private data inside a git repo"
  homepage "https://git-secret.io"
  license "MIT"
  head "https://github.com/sobolevn/git-secret.git"

  stable do
    url "https://github.com/sobolevn/git-secret/archive/v0.4.0.tar.gz"
    sha256 "ae17bfda88eb77e8f07c5f16d833792a3a14adc9c5d2bbc840f28538c62f08ba"
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8b19c1a419d844931e68bc21b0097c2d9c17275f66de939cafe6a13df91dafb3"
    sha256 cellar: :any_skip_relocation, big_sur:       "2bd6c524c359601a854696aa0b7fed558e6c5dc45791feced47f33e06103dafe"
    sha256 cellar: :any_skip_relocation, catalina:      "2bd6c524c359601a854696aa0b7fed558e6c5dc45791feced47f33e06103dafe"
    sha256 cellar: :any_skip_relocation, mojave:        "2bd6c524c359601a854696aa0b7fed558e6c5dc45791feced47f33e06103dafe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8be47366babeccfc6d87dfdc305deb4bb287e7ed5cde997799a5dfa816c622a3" # linuxbrew-core
  end

  depends_on "gawk"
  depends_on "gnupg"

  def install
    system "make", "build"
    system "bash", "utils/install.sh", prefix
  end

  test do
    (testpath/"batch.gpg").write <<~EOS
      Key-Type: RSA
      Key-Length: 2048
      Subkey-Type: RSA
      Subkey-Length: 2048
      Name-Real: Testing
      Name-Email: testing@foo.bar
      Expire-Date: 1d
      %no-protection
      %commit
    EOS
    begin
      system Formula["gnupg"].opt_bin/"gpg", "--batch", "--gen-key", "batch.gpg"
      system "git", "init"
      system "git", "config", "user.email", "testing@foo.bar"
      system "git", "secret", "init"
      assert_match "testing@foo.bar added", shell_output("git secret tell -m")
      (testpath/"shh.txt").write "Top Secret"
      (testpath/".gitignore").append_lines "shh.txt"
      system "git", "secret", "add", "shh.txt"
      system "git", "secret", "hide"
      assert_predicate testpath/"shh.txt.secret", :exist?
    ensure
      system Formula["gnupg"].opt_bin/"gpgconf", "--kill", "gpg-agent"
    end
  end
end
