class GoStatik < Formula
  desc "Embed files into a Go executable"
  homepage "https://github.com/rakyll/statik"
  url "https://github.com/rakyll/statik/archive/v0.1.7.tar.gz"
  sha256 "cd05f409e63674f29cff0e496bd33eee70229985243cce486107085fab747082"
  license "Apache-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5960b8ab88990df3e2a3ef0578da24b674d72c620466af263fdad6b479133fe9"
    sha256 cellar: :any_skip_relocation, big_sur:       "0f05d7b15227e1bdf7be3876d90135232083ae1789c08d32641777b9291ef8a7"
    sha256 cellar: :any_skip_relocation, catalina:      "d6d3e13adce186f49cf35be7be414baec7cfa02e8d884e0a97ec9f15108f4cb4"
    sha256 cellar: :any_skip_relocation, mojave:        "93f27ec30935befbde2afab7ac3382a2e576b8a51024db2dd8a911860fb5b10f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a5dd1784337e41e3b0fb9c9f4dd2910d9a4b4b2218e1d4fa99e3540c655beed4" # linuxbrew-core
  end

  depends_on "go" => :build

  conflicts_with "statik", because: "both install `statik` binaries"

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w"
    mv bin/"go-statik", bin/"statik"
  end

  test do
    font_name = (MacOS.version >= :catalina) ? "Arial Unicode.ttf" : "Arial.ttf"
    font_path = "/Library/Fonts/#{font_name}"
    on_linux do
      font_path = "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
    end
    system bin/"statik", "-src", font_path
    assert_predicate testpath/"statik/statik.go", :exist?
    refute_predicate (testpath/"statik/statik.go").size, :zero?
  end
end
