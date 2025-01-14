class Mruby < Formula
  desc "Lightweight implementation of the Ruby language"
  homepage "https://mruby.org/"
  url "https://github.com/mruby/mruby/archive/3.0.0.tar.gz"
  sha256 "95b798cdd931ef29d388e2b0b267cba4dc469e8722c37d4ef8ee5248bc9075b0"
  license "MIT"
  head "https://github.com/mruby/mruby.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cc2d97074393cbb8ea736fb513759bfe505962cf19348476697a3cd72687f82f"
    sha256 cellar: :any_skip_relocation, big_sur:       "e500f9c72174e7a92a3151ddc39d137f8e243f46f1c81201efa8855a9d78aad0"
    sha256 cellar: :any_skip_relocation, catalina:      "346991d6204ce4e9a745c8b20e8a0f1d308c5b9a46aae05b0acc9d3845f79633"
    sha256 cellar: :any_skip_relocation, mojave:        "aa2812c5a7a2296671a88a989c94613e1ff2e91b6f8fa8579fef3b862699393a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c40e1324ce7a1919dcc3210e577a7ebbba61df14c0e95e704e1814bfa42a5dec" # linuxbrew-core
  end

  depends_on "bison" => :build

  uses_from_macos "ruby"

  def install
    cp "build_config/default.rb", buildpath/"homebrew.rb"
    inreplace buildpath/"homebrew.rb",
      "conf.gembox 'default'",
      "conf.gembox 'full-core'"
    ENV["MRUBY_CONFIG"] = buildpath/"homebrew.rb"

    system "make"

    cd "build/host/" do
      lib.install Dir["lib/*.a"]
      prefix.install %w[bin mrbgems mrblib]
    end

    prefix.install "include"
  end

  test do
    system "#{bin}/mruby", "-e", "true"
  end
end
