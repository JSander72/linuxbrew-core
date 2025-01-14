class Colfer < Formula
  desc "Schema compiler for binary data exchange"
  homepage "https://github.com/pascaldekloe/colfer"
  url "https://github.com/pascaldekloe/colfer/archive/v1.8.1.tar.gz"
  sha256 "5d184c8a311543f26c957fff6cad3908b9b0a4d31e454bb7f254b300d004dca7"
  license "CC0-1.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e909fd6305c6b00a1499756f250666ccb80a285b2cd1115aa95edb6e31593ea7"
    sha256 cellar: :any_skip_relocation, big_sur:       "9ee59a49a4e15f40a620d526039cb8ef82e5c323f59f6df3074f1aa153c3fea4"
    sha256 cellar: :any_skip_relocation, catalina:      "dfdb2743960de62ee18ab35a7ead3d2d8de4207cc6ffa11ff0d8ebf393a591e8"
    sha256 cellar: :any_skip_relocation, mojave:        "dfdb2743960de62ee18ab35a7ead3d2d8de4207cc6ffa11ff0d8ebf393a591e8"
    sha256 cellar: :any_skip_relocation, high_sierra:   "dfdb2743960de62ee18ab35a7ead3d2d8de4207cc6ffa11ff0d8ebf393a591e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e473145b34ba1d5b5fad2513999bb049f25b4515967ad207ed7ad6c8261963b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-o", bin/"colf", "./cmd/colf"
  end

  test do
    (testpath/"try.colf").write <<~EOS
      // Package try is an integration test.
      package try

      // O is an arbitrary data structure.
      type O struct {
        S text
      }
    EOS
    system bin/"colf", "C", testpath/"try.colf"
    system ENV.cc, "-c", "Colfer.c"
  end
end
