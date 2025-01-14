class Bcrypt < Formula
  desc "Cross platform file encryption utility using blowfish"
  homepage "https://bcrypt.sourceforge.io/"
  url "https://bcrypt.sourceforge.io/bcrypt-1.1.tar.gz"
  sha256 "b9c1a7c0996a305465135b90123b0c63adbb5fa7c47a24b3f347deb2696d417d"
  license "BSD-3-Clause"

  livecheck do
    url "http://bcrypt.sourceforge.net/"
    strategy :page_match
    regex(/href=.*?bcrypt[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7b3e672ab9055b69dc1c7c5a7d13ad3a9a375f60de85cfcc5268f7eb139edcda"
    sha256 cellar: :any_skip_relocation, big_sur:       "9c3948e719b6b5cb195fc30c8e0fd555c35d9fcea7a5a6c607b094ce2e097f01"
    sha256 cellar: :any_skip_relocation, catalina:      "132998cb8e196f506666943a94a26927a19899cb1e45ee8eaf65e5ad0ee7ef8d"
    sha256 cellar: :any_skip_relocation, mojave:        "bb843c3b04f9adf57df1c2d07e30303626eedb0f45695dcaf38d0835ea3e35fd"
    sha256 cellar: :any_skip_relocation, high_sierra:   "883a4a97b7275e91cd90ab9d1ca69fa2a3c0db3544a2d77863a37bda16c51667"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7277b7a96e6eca5b00de7b7f91c60a300e128b3b03387df5338b4c67f147860" # linuxbrew-core
  end

  uses_from_macos "zlib"

  def install
    system "make", "CC=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "LDFLAGS=-lz"
    bin.install "bcrypt"
    man1.install gzip("bcrypt.1")
  end

  test do
    (testpath/"test.txt").write("Hello World!")
    pipe_output("#{bin}/bcrypt -r test.txt", "12345678\n12345678\n")
    mv "test.txt.bfe", "test.out.txt.bfe"
    pipe_output("#{bin}/bcrypt -r test.out.txt.bfe", "12345678\n")
    assert_equal File.read("test.txt"), File.read("test.out.txt")
  end
end
