class Rargs < Formula
  desc "Util like xargs + awk with pattern matching support"
  homepage "https://github.com/lotabout/rargs"
  url "https://github.com/lotabout/rargs/archive/v0.3.0.tar.gz"
  sha256 "22d9aa4368a0f9d1fd82391439d3aabf4ddfb24ad674a680d6407c9e22969da3"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3c71f1e62276add0bbd57cf43b004a30344374aa1b598185a366f20fb00bae55"
    sha256 cellar: :any_skip_relocation, big_sur:       "7162affe2bbca5025e60c46ccfd9c9f9882383972ebbc5e550d6e4aa12041bd2"
    sha256 cellar: :any_skip_relocation, catalina:      "37d5a3c2a5608eb4a10df0814a1334b88602a7200fdf99db60113f7aea598489"
    sha256 cellar: :any_skip_relocation, mojave:        "1c24f60f8b91301cd167b0040e2c9ec7895fe818eeb21f13d40fca94e6f4f08b"
    sha256 cellar: :any_skip_relocation, high_sierra:   "9cea3ec1abc342281b94649496e0d28275eead691238a2d03e47c2621afc9801"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25eba46b8fd020e3428667688f69136105c3dd92eff27b399e9cda3c61754127" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal "abc", shell_output("echo abc,def | #{bin}/rargs -d, echo {1}").chomp
  end
end
