class Direnv < Formula
  desc "Load/unload environment variables based on $PWD"
  homepage "https://direnv.net/"
  url "https://github.com/direnv/direnv/archive/v2.28.0.tar.gz"
  sha256 "fa539c63034b6161d8238299bb516dcec79e8905cd43ff2b9559ad6bf047cc93"
  license "MIT"
  head "https://github.com/direnv/direnv.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8fabe33920273c377ace461d6f2ff02a78569b230b7625402086ea4ebeffff38"
    sha256 cellar: :any_skip_relocation, big_sur:       "64680c7245384e3cd59c4e0b9a1f32e5f0a26f5591b77c3736ed9160191571c3"
    sha256 cellar: :any_skip_relocation, catalina:      "c10f6a3b721b2c5c12b8bb3604bba9af3946edcada447327afa074b6c39e6996"
    sha256 cellar: :any_skip_relocation, mojave:        "8f1a615929f583478efb0c6853754dba806f94d95ed67c43f36062d95e50c636"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e389ae91e3cd74ca1264bd34349d0ab2dc9ae8f5b6106727f7f1a6c883849bb" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"direnv", "status"
  end
end
