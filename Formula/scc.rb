class Scc < Formula
  desc "Fast and accurate code counter with complexity and COCOMO estimates"
  homepage "https://github.com/boyter/scc/"
  url "https://github.com/boyter/scc/archive/v3.0.0.tar.gz"
  sha256 "01b903e27add5180f5000b649ce6e5088fa2112e080bfca1d61b1832a84a0645"
  license any_of: ["MIT", "Unlicense"]

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3c4d0faf74445889e647a4366f428dfada194b66be43bcae45e8493b21d02187"
    sha256 cellar: :any_skip_relocation, big_sur:       "e55821dfc18b02de3be5dec72881c65085ffa0b5a446179b86a151db5780577c"
    sha256 cellar: :any_skip_relocation, catalina:      "8f425e7b1f10563d69e459bb5ce07e5cf87512c4eb0923acb2618e0b0f1184f8"
    sha256 cellar: :any_skip_relocation, mojave:        "81f89e5d3ba8358b052378b2c68bab24ade5d75ec8561b2e2b16b7de065c8d56"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "67f756d5090e8226482efee1d1ff8aa74684e184add296ac310603bb64c753c9" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      int main(void) {
        return 0;
      }
    EOS

    expected_output = <<~EOS
      Language,Lines,Code,Comments,Blanks,Complexity,Bytes
      C,4,4,0,0,0,50
    EOS

    assert_match expected_output, shell_output("#{bin}/scc -fcsv test.c")
  end
end
