class Hivemind < Formula
  desc "Process manager for Procfile-based applications"
  homepage "https://github.com/DarthSim/hivemind"
  url "https://github.com/DarthSim/hivemind/archive/v1.0.6.tar.gz"
  sha256 "8ca7884db49268b7938d0503e7e95443cb3a56696478d5dcc2b9813705525a39"
  license "MIT"
  head "https://github.com/DarthSim/hivemind.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "978dcd1f37d644e59dd194f4bc1a5f506fce93bef7313e0f8f944e3444b8b26a"
    sha256 cellar: :any_skip_relocation, big_sur:       "792e06f04a8f0742bb4f0467c24d42a92cce9c403827ebc2055a0a891c5c07f8"
    sha256 cellar: :any_skip_relocation, catalina:      "ed80238e557ca71f115b2b3cd5031bfac16a3d02d8b37b386b629d89dd26af48"
    sha256 cellar: :any_skip_relocation, mojave:        "8e6f70ca5e0c8eb1e42d47bee207ec5333b453660d808103a36d53c51a7fb59a"
    sha256 cellar: :any_skip_relocation, high_sierra:   "7a89018774693681975cea22dcdebe35df043507476d1318f195e6d194978693"
    sha256 cellar: :any_skip_relocation, sierra:        "4aa25b52b5c7fd3dc7ae29ab31cf19eeddde4e7685fd7e9838be0ea8cf09f3c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e74b7949bb598fe11915c409c0028787bf0d97a7dc915df165dac884077a372b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"
    (buildpath/"src/github.com/DarthSim/hivemind/").install Dir["*"]
    system "go", "build", "-o", "#{bin}/hivemind", "-v", "github.com/DarthSim/hivemind/"
  end

  test do
    (testpath/"Procfile").write("test: echo 'test message'")
    assert_match "test message", shell_output("#{bin}/hivemind")
  end
end
