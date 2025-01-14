require "language/node"

class WriteGood < Formula
  desc "Naive linter for English prose"
  homepage "https://github.com/btford/write-good"
  url "https://registry.npmjs.org/write-good/-/write-good-1.0.8.tgz"
  sha256 "f54db3db8db0076fd1c05411c7f3923f055176632c51dc4046ab216e51130221"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "61d0833a983986732c1d6abb5491a3cc787f30c6987d2c420ef69af5a82e8340"
    sha256 cellar: :any_skip_relocation, big_sur:       "9d0239747d4aaff293b839c0cd3d4ee175eb69260d965d810b33b4081a20845c"
    sha256 cellar: :any_skip_relocation, catalina:      "1bb59d5fc6bc1e3350b3ff45eef3aa3e78500e3cd9342c690f6dcf8b6163a77b"
    sha256 cellar: :any_skip_relocation, mojave:        "0850f0679ded1af752f6f62b3f88e80134563cfd6d313c9d9b7e42549d421d9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0bd35edfcf38c6e4bc7229ae689113447e142e34c4954c6e867a14daf0e21ec0" # linuxbrew-core
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.txt").write "So the cat was stolen."
    assert_match "passive voice", shell_output("#{bin}/write-good test.txt", 2)
  end
end
