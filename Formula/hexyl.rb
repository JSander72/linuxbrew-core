class Hexyl < Formula
  desc "Command-line hex viewer"
  homepage "https://github.com/sharkdp/hexyl"
  url "https://github.com/sharkdp/hexyl/archive/v0.9.0.tar.gz"
  sha256 "73f0dc1be1eaa1a34e3280bc1eeb4f86f34b024205fc7bf3c87d5a0bc4021a6a"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b93b1b33e9915f766a189758d96f9383a661153908ac5043e13921445639e503"
    sha256 cellar: :any_skip_relocation, big_sur:       "28782b657ead4ad2d73fb35036eae99bddb5b0c7abb949e9726159df1034bf1f"
    sha256 cellar: :any_skip_relocation, catalina:      "e981e7f1b7c694e34184e99fa9c7b8e8196308868879c5c7925633f8b19ae122"
    sha256 cellar: :any_skip_relocation, mojave:        "3cab619ac9a8f2de7809af2d5d84f8ae9ca556087a0cd7174fa1d8fc778256cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92f4908b139e1bdaee693bb0b57e68a1181ac0805cfb2c9113a92c91269e0f19" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    pdf = test_fixtures("test.pdf")
    output = shell_output("#{bin}/hexyl -n 100 #{pdf}")
    assert_match "00000000", output
  end
end
