class Dasel < Formula
  desc "JSON, YAML, TOML, XML, and CSV query and modification tool"
  homepage "https://github.com/TomWright/dasel"
  url "https://github.com/TomWright/dasel/archive/v1.16.0.tar.gz"
  sha256 "1dcfcdfb96db17331cbdfaf32a3d43d0a413d39a2a20c57b476fb993189f3444"
  license "MIT"
  head "https://github.com/TomWright/dasel.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8280106b8778c12220a1bc178ff9c9856f29d4a120569e713a662f7c0e0e9487"
    sha256 cellar: :any_skip_relocation, big_sur:       "d9bb259933a2f24df633163b88bbb66c14093a58476134e5adda323bdf543e94"
    sha256 cellar: :any_skip_relocation, catalina:      "a397d678cd5f1d5264ae718eadf5e0a26dc194ef1cc7e9dff730eaf34c0759f6"
    sha256 cellar: :any_skip_relocation, mojave:        "582a698518311b599a4913b115f2765a6b2770278d47fd8e2a6079f49c9e1304"
  end

  depends_on "go" => :build

  def install
    ldflags = "-X 'github.com/tomwright/dasel/internal.Version=#{version}'"
    system "go", "build", *std_go_args, "-ldflags", ldflags, "./cmd/dasel"
  end

  test do
    json = "[{\"name\": \"Tom\"}, {\"name\": \"Jim\"}]"
    assert_equal "Tom\nJim", pipe_output("#{bin}/dasel --plain -p json -m '.[*].name'", json).chomp
  end
end
