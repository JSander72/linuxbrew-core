class Bedtools < Formula
  desc "Tools for genome arithmetic (set theory on the genome)"
  homepage "https://github.com/arq5x/bedtools2"
  url "https://github.com/arq5x/bedtools2/archive/v2.30.0.tar.gz"
  sha256 "c575861ec746322961cd15d8c0b532bb2a19333f1cf167bbff73230a7d67302f"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d43458d5a8f50a7db0f7f728ed82c0a980d9202126624d594d17c99c2c9ea76d"
    sha256 cellar: :any_skip_relocation, big_sur:       "6554348743d3efba64e47294f8cb229229f168902234dd7e0ee0b4dfa85bb4d7"
    sha256 cellar: :any_skip_relocation, catalina:      "32d302a56df9044ce36d44db851318fc4fb45676086e48a6d913f2286ae3a756"
    sha256 cellar: :any_skip_relocation, mojave:        "69b80814d21b11edf9d45d67de8536d5db965dd6743e56079e1f3d6cf77bb6d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d44d69f1ac3364737dc6d8ec65f891c74380e604d464c31363f9fbd40cb2c3e7" # linuxbrew-core
  end

  depends_on "python@3.9" => :build
  depends_on "xz"

  uses_from_macos "bzip2"
  uses_from_macos "zlib"

  def install
    inreplace "Makefile", "python", "python3"

    system "make"
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"t.bed").write "c\t1\t5\nc\t4\t9"
    assert_equal "c\t1\t9", shell_output("#{bin}/bedtools merge -i t.bed").chomp
  end
end
