require "language/node"

class Ungit < Formula
  desc "Easiest way to use Git. On any platform. Anywhere"
  homepage "https://github.com/FredrikNoren/ungit"
  url "https://registry.npmjs.org/ungit/-/ungit-1.5.18.tgz"
  sha256 "7bc917ccbb9aa33773b8915400c4c7fbae375a346dba6613e5b0eaae7cad6fb8"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "54ab4e9703e79db7145005c5f4e8a2b09001bc6a6a4c0ca0e074d20cb71b252a"
    sha256 cellar: :any_skip_relocation, big_sur:       "6768008e7ce0700279019566b2c5fab0a906823696b225e54b883bc30d4b52b7"
    sha256 cellar: :any_skip_relocation, catalina:      "6768008e7ce0700279019566b2c5fab0a906823696b225e54b883bc30d4b52b7"
    sha256 cellar: :any_skip_relocation, mojave:        "6768008e7ce0700279019566b2c5fab0a906823696b225e54b883bc30d4b52b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6becd0bc7ca5264cd98e44664d8186e22fc22bc6083cec8901ad290bd52527aa" # linuxbrew-core
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    port = free_port

    fork do
      exec bin/"ungit", "--no-launchBrowser", "--port=#{port}"
    end
    sleep 8

    assert_includes shell_output("curl -s 127.0.0.1:#{port}/"), "<title>ungit</title>"
  end
end
