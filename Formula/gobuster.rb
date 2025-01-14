class Gobuster < Formula
  desc "Directory/file & DNS busting tool written in Go"
  homepage "https://github.com/OJ/gobuster"
  url "https://github.com/OJ/gobuster.git",
      tag:      "v3.1.0",
      revision: "f5051ed456dc158649bb8bf407889ab0978bf1ba"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e6e7f65fbed3896cb3b63eefddd16de3b621a8d72b205d24b8f7abd21379f87e"
    sha256 cellar: :any_skip_relocation, big_sur:       "8342b115722243f5c108de8ecdb5aefd20ae5deb884e48732c80595c24897f0d"
    sha256 cellar: :any_skip_relocation, catalina:      "f8f36299b36b59006637dcc7d062614eb209ba82a31f5a67fce789c4d6ef9562"
    sha256 cellar: :any_skip_relocation, mojave:        "16912d38db06501d02cdab6066d1da01129779d958ce142c40018cce30328fc4"
    sha256 cellar: :any_skip_relocation, high_sierra:   "341ce02f5e99ba1bf9cee8d6cbdd150a6e36d8b0fd811ded7a2da8933d877f9a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c965314548c15ef709834bcc6ab25c57b5f6b69797f1c7e7e29121ac6c6e3fad" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", "-trimpath", "-o", bin/"gobuster"
    prefix.install_metafiles
  end

  test do
    (testpath/"words.txt").write <<~EOS
      dog
      cat
      horse
      snake
      ape
    EOS

    output = shell_output("#{bin}/gobuster dir -u https://buffered.io -w words.txt 2>&1")
    assert_match "Finished", output
  end
end
