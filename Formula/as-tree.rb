class AsTree < Formula
  desc "Print a list of paths as a tree of paths 🌳"
  homepage "https://github.com/jez/as-tree"
  url "https://github.com/jez/as-tree/archive/0.12.0.tar.gz"
  sha256 "2af03a2b200041ac5c7a20aa1cea0dcc21fb83ac9fe9a1cd63cb02adab299456"
  license "BlueOak-1.0.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "88d57e70554e56a2405b3369e6ae2d1e507b5dc331d2c5b1bbf82726fe13b87a"
    sha256 cellar: :any_skip_relocation, big_sur:       "7397711b05fca437e6cc9489ef118a2c5b997a16190ecfdd7df773b749f5903a"
    sha256 cellar: :any_skip_relocation, catalina:      "2a83bda57ef793c3c3316df0e365175d0207b7bfd9083aeb82120516713bfb77"
    sha256 cellar: :any_skip_relocation, mojave:        "f2d560a3a379e279de99857983c7857f5da4ed16f42ce890a727853cf71ec224"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f18db34d58f6cffbd5cb6d402825a25fd08e59841810f12277b77d38559ef0c" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal ".\n└── file\n", pipe_output("#{bin}/as-tree", "file")
  end
end
