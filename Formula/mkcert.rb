class Mkcert < Formula
  desc "Simple tool to make locally trusted development certificates"
  homepage "https://github.com/FiloSottile/mkcert"
  url "https://github.com/FiloSottile/mkcert/archive/v1.4.3.tar.gz"
  sha256 "eaaf25bf7f6e047dc4da4533cdd5780c143a34f076f3a8096c570ac75a9225d9"
  license "BSD-3-Clause"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "053f02796ab0165faaabc470cc161559d3ba5062b5e56f6df1bbd46a828f4991"
    sha256 cellar: :any_skip_relocation, big_sur:       "4dc2370651718c72f2484c81a6dd5813cb7fcf6a5ec6bb1bee94e1720d23d412"
    sha256 cellar: :any_skip_relocation, catalina:      "92ac9e87e65741d1cadb0372b259291dcd726fe1048715cfc993053cb62273e1"
    sha256 cellar: :any_skip_relocation, mojave:        "49c14e8620ffb1dc44d587eea2a6c329bac516f24d209d08b656b0c21af4e3ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "edf2e1f8ef7922dc1d362bffea95f76fcce0289e19d020543fffec9a11462b8f" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w -X main.Version=v#{version}"
  end

  test do
    ENV["CAROOT"] = testpath
    system bin/"mkcert", "brew.test"
    assert_predicate testpath/"brew.test.pem", :exist?
    assert_predicate testpath/"brew.test-key.pem", :exist?
    output = (testpath/"brew.test.pem").read
    assert_match "-----BEGIN CERTIFICATE-----", output
    output = (testpath/"brew.test-key.pem").read
    assert_match "-----BEGIN PRIVATE KEY-----", output
  end
end
