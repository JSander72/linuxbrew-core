class GitTest < Formula
  desc "Run tests on each distinct tree in a revision list"
  homepage "https://github.com/spotify/git-test"
  url "https://github.com/spotify/git-test/archive/v1.0.4.tar.gz"
  sha256 "7c2331c8dc3c815e440ffa1a4dc7a9ff8a28a0a8cbfd195282f53c3e4cb2ee00"
  license "Apache-2.0"

  def install
    bin.install "git-test"
    man1.install "git-test.1"
    pkgshare.install "test.sh"
  end

  test do
    ENV["XDG_CONFIG_HOME"] = testpath/".config"
    ENV["GIT_CONFIG_NOSYSTEM"] = "1"
    system "git", "init"
    ln_s bin/"git-test", testpath
    cp pkgshare/"test.sh", testpath
    chmod 0755, "test.sh"
    system "git", "add", "test.sh"
    system "git", "commit", "-m", "initial commit"
    ENV["TERM"] = "xterm"
    system bin/"git-test", "-v", "HEAD", "--verify='./test.sh'"
  end
end
