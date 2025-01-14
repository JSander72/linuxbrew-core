class Dog < Formula
  desc "Command-line DNS client"
  homepage "https://dns.lookup.dog/"
  url "https://github.com/ogham/dog/archive/v0.1.0.tar.gz"
  sha256 "82387d38727bac7fcdb080970e84b36de80bfe7923ce83f993a77d9ac7847858"
  license "EUPL-1.2"
  head "https://github.com/ogham/dog.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9ea5dead4f4fbe142d855e32dbb2a01a311836bdbdec746c62eb21e1c5a8b159"
    sha256 cellar: :any_skip_relocation, big_sur:       "0666eb89b99b25ee0c5b2064f2a7a2781a325aded61691b707c6e93c512c652f"
    sha256 cellar: :any_skip_relocation, catalina:      "21f901c6abb536f0a7bc00d97df6e561aec1acff1759a96a5f69bd51eac1da98"
    sha256 cellar: :any_skip_relocation, mojave:        "095b6dbb23b96504a6f0e0a292a7157c78e900825e92f4c140cc29643a294e29"
    sha256 cellar: :any_skip_relocation, high_sierra:   "fef7ea4d925e230ba9e75cb051a888263c2bc10fcf26a96899cea2cc8891a302"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "be1886badafae20525508c36536fa9926d673506f45e8943469008a2311240a2" # linuxbrew-core
  end

  depends_on "just" => :build
  depends_on "pandoc" => :build
  depends_on "rust" => :build

  on_linux do
    depends_on "pkg-config" => :build
    depends_on "openssl@1.1"
  end

  def install
    system "cargo", "install", *std_cargo_args
    bash_completion.install "completions/dog.bash" => "dog"
    zsh_completion.install "completions/dog.zsh" => "_dog"
    fish_completion.install "completions/dog.fish"
    system "just", "man"
    man1.install "target/man/dog.1"
  end

  test do
    output = shell_output("#{bin}/dog dns.google A --seconds --color=never")
    assert_match(/^A\s+dns\.google\.\s+\d+\s+8\.8\.4\.4/, output)
    assert_match(/^A\s+dns\.google\.\s+\d+\s+8\.8\.8\.8/, output)
  end
end
