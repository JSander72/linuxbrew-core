class Loc < Formula
  desc "Count lines of code quickly"
  homepage "https://github.com/cgag/loc"
  url "https://github.com/cgag/loc/archive/v0.4.1.tar.gz"
  sha256 "1e8403fd9a3832007f28fb389593cd6a572f719cd95d85619e7bbcf3dbea18e5"
  license "MIT"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "39a68ff6b68af077cf2c2c3c7fedcb534dcc1220bd4cc3e64e7443efdf599bd9"
    sha256 cellar: :any_skip_relocation, big_sur:       "499912987d82682d5bfebd638d9a116c0d55f71284bf543067abb086bc9c55a3"
    sha256 cellar: :any_skip_relocation, catalina:      "2a8ac9341661cefa1221418aa2cb5cdd5207108ade6803ab5af34ca01d0aef13"
    sha256 cellar: :any_skip_relocation, mojave:        "008db46fed420d7ec698d46e059a4913368af4d8f0b2f4f8502a39ee392b830d"
    sha256 cellar: :any_skip_relocation, high_sierra:   "f4241a70db520e24c587649bf7b8db0f743afaf00b01ebee5934bee7e88ae42e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fdf1e18b1c387df11367627c1b511297d0412f9b075e5e41b638ebed34bbc23f" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <stdio.h>
      int main() {
        println("Hello World");
        return 0;
      }
    EOS
    system bin/"loc", "test.cpp"
  end
end
