class Exenv < Formula
  desc "Elixir versions management tool"
  homepage "https://github.com/mururu/exenv"
  url "https://github.com/mururu/exenv/archive/v0.1.0.tar.gz"
  sha256 "368095760ecc386a0930954f5f0ce7cea977641fe6d27b1beff032f512598a58"
  license "MIT"
  head "https://github.com/mururu/exenv.git"

  def install
    inreplace "libexec/exenv", "/usr/local", HOMEBREW_PREFIX
    prefix.install Dir["*"]
  end

  test do
    system "#{bin}/exenv", "init", "-"
  end
end
