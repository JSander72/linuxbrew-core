class Scmpuff < Formula
  desc "Adds numbered shortcuts for common git commands"
  homepage "https://mroth.github.io/scmpuff/"
  url "https://github.com/mroth/scmpuff/archive/v0.3.0.tar.gz"
  sha256 "239cd269a476f5159a15ef462686878934617b11317fdc786ca304059c0b6a0b"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "152725eafc16f39267d4ffc3bf99953be7fe024b01593721fc5adadc244ddbfe"
    sha256 cellar: :any_skip_relocation, big_sur:       "0741427c472b244575c9d7735e85f971677645107ea91ae99f32cc0377dc93ca"
    sha256 cellar: :any_skip_relocation, catalina:      "0d673b2326d88ca0b4c952122f37d8c2cc269bf687e62f0161a9a75288b6ccbb"
    sha256 cellar: :any_skip_relocation, mojave:        "30853a0768a6b6c65bdd0522854ae335f50f80ea24bbc64fd16a5411fcd7f2d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8b4b16906375d72f0bc3323583e274636bd0db31b41eee35e829da7a61a4c7f" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -v -X main.VERSION=#{version}"
  end

  test do
    ENV["e1"] = "abc"
    assert_equal "abc", shell_output("#{bin}/scmpuff expand 1").strip
  end
end
