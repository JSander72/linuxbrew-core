class Ffuf < Formula
  desc "Fast web fuzzer written in Go"
  homepage "https://github.com/ffuf/ffuf"
  url "https://github.com/ffuf/ffuf/archive/v1.3.1.tar.gz"
  sha256 "136df36154f17668fb726120f0c93059f696786a34e3c2047d61efc3a065c4ec"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3bddc7faf7303fc75c6d8aa68969f4f407b0858eb883f6ce770a42066a8d1b9d"
    sha256 cellar: :any_skip_relocation, big_sur:       "ccb35a18f2cdc4b3b0fe847b1a6fc89fce8744701aaf39fec630454c5e72b285"
    sha256 cellar: :any_skip_relocation, catalina:      "8d2faa6265f9c7703ad6f8d05abdb0d0a711b8e93db162fb205e46cfe577e920"
    sha256 cellar: :any_skip_relocation, mojave:        "fa307cbcfc231d2016659b76e8542f109377bfc4e865f1cff04825a608240e66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00cd869b8dbcaf1c069510229b62b63435ef86f4cfedb17ee2ac520475fe0ae4" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w"
  end

  test do
    (testpath/"words.txt").write <<~EOS
      dog
      cat
      horse
      snake
      ape
    EOS

    output = shell_output("#{bin}/ffuf -u https://example.org/FUZZ -w words.txt 2>&1")
    assert_match %r{:: Progress: \[5/5\].*Errors: 0 ::$}, output
  end
end
