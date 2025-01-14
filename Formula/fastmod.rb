class Fastmod < Formula
  desc "Fast partial replacement for the codemod tool"
  homepage "https://github.com/facebookincubator/fastmod"
  url "https://github.com/facebookincubator/fastmod/archive/v0.4.2.tar.gz"
  sha256 "5afb4c449aa7d1efe34e0540507fc1d1f40f7eba0861b2bb10409080faeffc4a"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "944418b3f91541220ab28960c152587749dc6cb56c18f099b40371c00765a01b"
    sha256 cellar: :any_skip_relocation, big_sur:       "09e462f4355d7dcac277c027280d87f5da45c07d97e20bb36cb1419e03e23137"
    sha256 cellar: :any_skip_relocation, catalina:      "b775cece5ec1a8af87f117eb9946569632c95b878242ef94370ecda978bd3989"
    sha256 cellar: :any_skip_relocation, mojave:        "48985e1b88574be11d01213776f125f4fbf45aaf4f4cdbf71c0341e1faf60a49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e0e97754e4782cdb0b51e9a67956b3cf58e5b4ea0735dfc292c5ae88c601220" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"input.txt").write("Hello, World!")
    system bin/"fastmod", "-d", testpath, "--accept-all", "World", "fastmod"
    assert_equal "Hello, fastmod!", (testpath/"input.txt").read
  end
end
