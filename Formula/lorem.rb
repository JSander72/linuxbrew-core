class Lorem < Formula
  desc "Python generator for the console"
  homepage "https://github.com/per9000/lorem"
  url "https://github.com/per9000/lorem/archive/v0.8.0.tar.gz"
  sha256 "3eec439d616a044e61a6733730b1fc009972466f869dae358991f95abd57e8b3"
  license "GPL-3.0-or-later"
  head "https://github.com/per9000/lorem.git"

  def install
    bin.install "lorem"
  end

  test do
    assert_equal "lorem ipsum", shell_output("#{bin}/lorem -n 2").strip.downcase
  end
end
