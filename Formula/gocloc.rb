class Gocloc < Formula
  desc "Little fast LoC counter"
  homepage "https://github.com/hhatto/gocloc"
  url "https://github.com/hhatto/gocloc/archive/v0.4.1.tar.gz"
  sha256 "528be5009996b4177936be508aa494c289adddf58e4694b1a36067bda433f783"
  license "MIT"
  head "https://github.com/hhatto/gocloc.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c6dc9d0d5c3a9da085aacd59dbd63516d9534dce80feb98e9b24f9972bd7dc99"
    sha256 cellar: :any_skip_relocation, big_sur:       "d4afbefd3a175ef99e40ec8806a202f977738453f4dbcfee03c5c6edb71cd06d"
    sha256 cellar: :any_skip_relocation, catalina:      "05e693c773c83c26b0ce21f3970407c17f1d5858402f7cded3c2032e52f86d19"
    sha256 cellar: :any_skip_relocation, mojave:        "83e435c8906ee9c2a57fb8799f08a4a63c1b3a6cc34f18594f09226f7d61e21e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9cfaac2ff8b96865e8ebcc4b24c37aa471aec65f65f6804ed377bd7b69a7aeae" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/gocloc"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      int main(void) {
        return 0;
      }
    EOS

    assert_equal "{\"languages\":[{\"name\":\"C\",\"files\":1,\"code\":4,\"comment\":0," \
                 "\"blank\":0}],\"total\":{\"files\":1,\"code\":4,\"comment\":0,\"blank\":0}}",
                 shell_output("#{bin}/gocloc --output-type=json .")
  end
end
