class Jsonpp < Formula
  desc "Command-line JSON pretty-printer"
  homepage "https://jmhodges.github.io/jsonpp/"
  url "https://github.com/jmhodges/jsonpp/archive/1.3.0.tar.gz"
  sha256 "dde8ea9b270a79cd2b2f40824f89abc5270bd360122d87ab04b4361c0015d941"
  license "MIT"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3837bd3507a7ab6565e04c1d9b1d551d62be51f14233ba92405ca21d4d0e4633"
    sha256 cellar: :any_skip_relocation, big_sur:       "3711ce93b4d3874fbfe7967755b587f5787534dbdc12ab6f36eea6a41b54b712"
    sha256 cellar: :any_skip_relocation, catalina:      "2b84ea4f8d4a4177064c1fbf024876439175c4e8c6576b33f93399c72afe3a5a"
    sha256 cellar: :any_skip_relocation, mojave:        "7c8dd8c69321e42c29e075a658840167138d16820ba6a0dd5f2f2425c87a569b"
    sha256 cellar: :any_skip_relocation, high_sierra:   "d81995103192bb58f66d7089939eb6682f117a7044d3a84804db62b4c31a3c81"
    sha256 cellar: :any_skip_relocation, sierra:        "219f8a6bfdf1d0e8435fa1c1fdf0cc22b91cae8ec7d62581d312927fabcf9388"
    sha256 cellar: :any_skip_relocation, el_capitan:    "3161f55711eea589c5036078fbf3a5df47484767f025adda7c0692d4dda5f2b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f6b0ca281c47061e910fda6992e548196ec11e3e5147a80467b6da48479f4097" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    system "go", "build", "-o", bin/"jsonpp"
  end

  test do
    expected = <<~EOS.chomp
      {
        "foo": "bar",
        "baz": "qux"
      }
    EOS
    assert_equal expected, pipe_output(bin/"jsonpp", '{"foo":"bar","baz":"qux"}')
  end
end
