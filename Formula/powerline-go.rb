class PowerlineGo < Formula
  desc "Beautiful and useful low-latency prompt for your shell"
  homepage "https://github.com/justjanne/powerline-go"
  url "https://github.com/justjanne/powerline-go/archive/v1.21.0.tar.gz"
  sha256 "eee6ef47676e42eccca3b7098a8b71c0854f7419f1bce13c72747217ce0661a3"
  license "GPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e88775c8b1a1912c3792a71206ab2d206ada9d2fca263eb7dbf9f62f9f680473"
    sha256 cellar: :any_skip_relocation, big_sur:       "ba6d575617e53cb30d27ae91fad3715d1e8b3bf747503d575b3d8ad7bbfe12ed"
    sha256 cellar: :any_skip_relocation, catalina:      "8d390fa6247c60d921a9897f63a1fe9ed13c5cdedaa73cb0895c96108881d519"
    sha256 cellar: :any_skip_relocation, mojave:        "61fdd9581af5d9d1c44bd90d0e1c317d6b172c5105d8157eb0196b20136df05d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "89e0109f61272942d5675542c775678c060e5c5cfa0ca8044e780378e6f4e06c" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-s -w", *std_go_args
  end

  test do
    system "#{bin}/#{name}"
  end
end
