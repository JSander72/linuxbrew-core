class Dory < Formula
  desc "Development proxy for docker"
  homepage "https://github.com/freedomben/dory"
  url "https://github.com/FreedomBen/dory/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "1571e54dab39bc7884523aabeedde71921e64a11ef25b9c59a7b63282f97a237"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cbe36a5c87731cae07c1de8b9f7e2cfc04e17bba6e1a6918678ef49f62256bad"
    sha256 cellar: :any_skip_relocation, big_sur:       "0b772ed42dcb84a49c2a223a2fd8a899b942deb457291bef1c281a825fa7069b"
    sha256 cellar: :any_skip_relocation, catalina:      "0b772ed42dcb84a49c2a223a2fd8a899b942deb457291bef1c281a825fa7069b"
    sha256 cellar: :any_skip_relocation, mojave:        "52197dfd1668a9c0c3c2daa1cd7e808d89bbb4ba3f3500746e60b56cbc05058b"
  end

  depends_on "ruby@2.7"

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "#{name}.gemspec"
    system "gem", "install", "#{name}-#{version}.gem"
    bin.install libexec/"bin/#{name}"
    bin.env_script_all_files(libexec/"bin", GEM_HOME: ENV["GEM_HOME"])
  end

  test do
    shell_output(bin/"dory")

    system "#{bin}/dory", "config-file"
    assert_predicate testpath/".dory.yml", :exist?, "Dory could not generate config file"

    version = shell_output(bin/"dory version")
    assert_match version.to_s, version, "Unexpected output of version"
  end
end
