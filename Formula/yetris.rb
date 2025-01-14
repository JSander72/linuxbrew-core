class Yetris < Formula
  desc "Customizable Tetris for the terminal"
  homepage "https://github.com/alexdantas/yetris"
  url "https://github.com/alexdantas/yetris/archive/v2.3.0.tar.gz"
  sha256 "720c222325361e855e2dcfec34f8f0ae61dd418867a87f7af03c9a59d723b919"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "bcaafa1c4c02615a805d252ce93cf8c38a60876b575867cc280795a00a1f2848"
    sha256 cellar: :any_skip_relocation, big_sur:       "d0d9c0ddd6f7f825024cb4e96978ad43919eb77a216e8788943f1c8d7bfa80bb"
    sha256 cellar: :any_skip_relocation, catalina:      "a43b346adc20fc7d4f84ec1300e839bb4e615ab40ccf8e1a591f099092ad6078"
    sha256 cellar: :any_skip_relocation, mojave:        "ace31e89cefd33d38a65864d7343baad6dbda23aee0ba2a10f6b19480b9708e0"
    sha256 cellar: :any_skip_relocation, high_sierra:   "21537f5957c5ce90281195e6d962363920bda756a6c965ca107c329ec712f126"
    sha256 cellar: :any_skip_relocation, sierra:        "cf350d8daaf62f863b7466477aebea02145abf1f14e50ee56ad324c99dcee018"
    sha256 cellar: :any_skip_relocation, el_capitan:    "fd08bc62fc0c4687ed7e76fe604c345a647fb52a348c55cf446fcbf52c7af8dd"
    sha256 cellar: :any_skip_relocation, yosemite:      "a14c5327ab931d7394b3f617422916eafbc76a936ac77e81a959b38aa223dd5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e315cc19ed59f4fcc842ae5e599f9550423b9fd7948d8f82c953e654e4522152" # linuxbrew-core
  end

  uses_from_macos "ncurses"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/yetris --version")
  end
end
