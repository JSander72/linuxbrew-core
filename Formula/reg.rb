class Reg < Formula
  desc "Docker registry v2 command-line client"
  homepage "https://r.j3ss.co"
  url "https://github.com/genuinetools/reg/archive/v0.16.1.tar.gz"
  sha256 "b65787bff71bff21f21adc933799e70aa9b868d19b1e64f8fd24ebdc19058430"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6bf430c32dbb66c850bf8c6acbe2fc2953a8ada29e12c0e7b474317fe537fffb"
    sha256 cellar: :any_skip_relocation, big_sur:       "ca9db7f72804b3701ea833c24802b5c81f4297d556482596cc755f67a1061dbb"
    sha256 cellar: :any_skip_relocation, catalina:      "566141035e7c94c92a4422addea68ea86431916055d14bfe5e20de79c3a6451c"
    sha256 cellar: :any_skip_relocation, mojave:        "fc74e858cf6aa00783292b40d24ddbe0597d53c0e2f04c66dbbb0f103cbb50ec"
    sha256 cellar: :any_skip_relocation, high_sierra:   "6c834ffc790787be203c01f7d153971f34d4c75f70245058717e4a13f0afcf79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d37843e5522b1d8a9083d46cb88c7fd97a5aae590ce2b957b14c16739327179b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "buster", shell_output("#{bin}/reg tags debian")
  end
end
