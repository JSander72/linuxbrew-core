class Jd < Formula
  desc "JSON diff and patch"
  homepage "https://github.com/josephburnett/jd"
  url "https://github.com/josephburnett/jd/archive/v1.4.0.tar.gz"
  sha256 "9b1547b3c34652c61944a59e1449b8f819f196b86808c006e85ae8816d6c4d06"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "567d80b08b78a787d813f8b5fc8119c60d082e7bfa2f641b1b807a6f85a69286"
    sha256 cellar: :any_skip_relocation, big_sur:       "043e88ba4881d02947cd922f8be0d26d581afcf1b877d433f8bb2f53e724a245"
    sha256 cellar: :any_skip_relocation, catalina:      "bf662b680167c6d28e9adf4d28ac35bb13fe6838255b9e6d4cf49be0a05cb920"
    sha256 cellar: :any_skip_relocation, mojave:        "c9a9b7acbab08f9717cf464bf2b00d970728d014ccb738fcb28af7502e8ef6d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0bc66354f3ccb0e34e66015717f5c5cdcb9f5c4965b75d8e570da5912d3148d0" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w"
  end

  test do
    (testpath/"a.json").write('{"foo":"bar"}')
    (testpath/"b.json").write('{"foo":"baz"}')
    expected = <<~EOF
      @ ["foo"]
      - "bar"
      + "baz"
    EOF
    output = shell_output("#{bin}/jd a.json b.json")
    assert_equal output, expected
  end
end
