class Gron < Formula
  desc "Make JSON greppable"
  homepage "https://github.com/tomnomnom/gron"
  url "https://github.com/tomnomnom/gron/archive/v0.6.1.tar.gz"
  sha256 "eef150a425aa4eaa8b2e36a75ee400d4247525403f79e24ed32ccb346dc653ff"
  license "MIT"
  head "https://github.com/tomnomnom/gron.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d083132bef855096318805ebd6733993c444c1c6e5a203525184b5517f19da1a"
    sha256 cellar: :any_skip_relocation, big_sur:       "18f72c72d99203bd58c670642d6c33fa9e1f67e6861212ba21f98b975df406f0"
    sha256 cellar: :any_skip_relocation, catalina:      "dc6b46a589f618ab5b2e9d4aea01bd75f0326f585085c3b1f12e266dda2e7e5d"
    sha256 cellar: :any_skip_relocation, mojave:        "2a0ad03c4c7dfd2098758be2c5b65f16107ce8c67b586a4679f9d871aaee09a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d845fa277fd9957de0401937879f4b2bf9c3d7ae5a228dc53f7f58db95c9857b" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w"
  end

  test do
    assert_equal <<~EOS, pipe_output("#{bin}/gron", "{\"foo\":1, \"bar\":2}")
      json = {};
      json.bar = 2;
      json.foo = 1;
    EOS
  end
end
