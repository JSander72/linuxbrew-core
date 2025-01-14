class Httpdiff < Formula
  desc "Compare two HTTP(S) responses"
  homepage "https://github.com/jgrahamc/httpdiff"
  url "https://github.com/jgrahamc/httpdiff/archive/v1.0.0.tar.gz"
  sha256 "b2d3ed4c8a31c0b060c61bd504cff3b67cd23f0da8bde00acd1bfba018830f7f"
  license "GPL-2.0"
  head "https://github.com/jgrahamc/httpdiff.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "290b6c6f1c990249cc760ee510f0669dd9e317ac169be71cd5fb945a8625413e"
    sha256 cellar: :any_skip_relocation, big_sur:       "bd0aa59b471dc747b3af50d5c1f4611ed2c4993eebe64ffb4d343d1d7bef0fbb"
    sha256 cellar: :any_skip_relocation, catalina:      "5731d30f22cf63bd619c18f0f91c4547c52f2ae1b38a2cfeb0316958e93995c1"
    sha256 cellar: :any_skip_relocation, mojave:        "6113414a69c11632f0088e478d6db0acc6b826db7937c3570e661152c58bd334"
    sha256 cellar: :any_skip_relocation, high_sierra:   "1432608ef9e3ffaac9fc3c6207e63d888dd2246e1c806bc6a57cab312f944aea"
    sha256 cellar: :any_skip_relocation, sierra:        "39a0d685904aba4c3e55ff22b4d231b8890c022a1eb0366dc264bbabc410a117"
    sha256 cellar: :any_skip_relocation, el_capitan:    "59b46605118f8789c10facd53e9d4ce4c9f54c8de85611d423984c4316a169eb"
    sha256 cellar: :any_skip_relocation, yosemite:      "d5919069e31192cfd6f7d33dd4ff80d2142a8c36d23b50291e914c158d91ffac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8028f7c507a2705d47916db827b7a8a42e7f1fdec83c63bb3096af514e661a6d" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    system "go", "build", "-o", bin/"httpdiff"
  end

  test do
    system bin/"httpdiff", "https://brew.sh/", "https://brew.sh/"
  end
end
