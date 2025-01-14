class Sd < Formula
  desc "Intuitive find & replace CLI"
  homepage "https://github.com/chmln/sd"
  url "https://github.com/chmln/sd/archive/v0.7.6.tar.gz"
  sha256 "faf33a97797b95097c08ebb7c2451ac9835907254d89863b10ab5e0813b5fe5f"
  license "MIT"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "18c80fe2725f822518e07c67d37f410ba97387ad956d83e57caf33ac29e80d25"
    sha256 cellar: :any_skip_relocation, big_sur:       "954897383d176858ae3756214f1cd328813aca21c8a1680e28574b75d60f176c"
    sha256 cellar: :any_skip_relocation, catalina:      "7a596311c78da626809ba278bd318499d9552ee8ada8ae302abe4b3481b2245e"
    sha256 cellar: :any_skip_relocation, mojave:        "779ae77105d505f8532438b83acb54f915b5a917c66aecfc21ecdd86cf550b5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5caff10c55e9f6b8fbf076fb6e0bed124e1207e6c074d38c27ec9fb17478437f" # linuxbrew-core
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    # Completion scripts and manpage are generated in the crate's build
    # directory, which includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/sd-*/out"].first
    man1.install "#{out_dir}/sd.1"
    bash_completion.install "#{out_dir}/sd.bash"
    fish_completion.install "#{out_dir}/sd.fish"
    zsh_completion.install "#{out_dir}/_sd"
  end

  test do
    assert_equal "after", pipe_output("#{bin}/sd before after", "before")
  end
end
