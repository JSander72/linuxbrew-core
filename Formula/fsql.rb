class Fsql < Formula
  desc "Search through your filesystem with SQL-esque queries"
  homepage "https://github.com/kashav/fsql"
  url "https://github.com/kashav/fsql/archive/v0.4.0.tar.gz"
  sha256 "5f028446e31f1a8be2f8a72cd2c1ae888e748220e4c4ece38a62fd8fe41bf70a"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "77ec663d81151aebf469db5626893d130ff21114f603227046999a27ea843f8f"
    sha256 cellar: :any_skip_relocation, big_sur:       "53d773ca5cba807627e4e3b7cdb36990c18c3b1944c847756c1acf95d99d6af6"
    sha256 cellar: :any_skip_relocation, catalina:      "c97d021f2047654b1141141bfdaceba40953a39cc150233cb9ec3bb85ee9b675"
    sha256 cellar: :any_skip_relocation, mojave:        "5d984747c498019e9950c57084e2549417dce8206ab489650fcba917ad7a30af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6605d3692e9c63ce0d91a3946c5d40510b6885be06fd33959063ba4deef7693" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w", "./cmd/fsql"
  end

  test do
    (testpath/"bar.txt").write("hello")
    (testpath/"foo/baz.txt").write("world")
    cmd = "#{bin}/fsql SELECT FULLPATH\\(name\\) FROM foo"
    assert_match %r{^foo\s+foo/baz.txt$}, shell_output(cmd)
    cmd = "#{bin}/fsql SELECT name FROM . WHERE name = bar.txt"
    assert_equal "bar.txt", shell_output(cmd).chomp
    cmd = "#{bin}/fsql SELECT name FROM . WHERE FORMAT\\(size\, GB\\) \\> 500"
    assert_equal "", shell_output(cmd)
  end
end
