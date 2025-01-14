class Cksfv < Formula
  desc "File verification utility"
  homepage "https://zakalwe.fi/~shd/foss/cksfv/"
  url "https://zakalwe.fi/~shd/foss/cksfv/files/cksfv-1.3.15.tar.bz2"
  sha256 "a173be5b6519e19169b6bb0b8a8530f04303fe3b17706927b9bd58461256064c"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://zakalwe.fi/~shd/foss/cksfv/files/"
    regex(/href=.*?cksfv[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a024ad7db7fd8bcc1ad251d6392963533b3d2733b3d9f1fa49dcdcdd11573b57"
    sha256 cellar: :any_skip_relocation, big_sur:       "a747f42a401eae71dd1931f2d09e8d215646f645ce3024a3702b6af36b22d242"
    sha256 cellar: :any_skip_relocation, catalina:      "9e0b05988d3af7d666d08c8d3f4d8792f043f899a88e689d819e0b1dfd4bc2b4"
    sha256 cellar: :any_skip_relocation, mojave:        "6110de963cf29500583d02ac6629abc215ec85ce13de8855b251e2aaa67bf6d7"
    sha256 cellar: :any_skip_relocation, high_sierra:   "309816a8249a73a40760807ce0e5801a3ad223b21eb2a2e4b4a1d4d99859ff8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f49b7f252ae2c8add2aacd2beffd346f79e526809892848ae1adc01ab1937a8" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    path = testpath/"foo"
    path.write "abcd"

    assert_match "#{path} ED82CD11", shell_output("#{bin}/cksfv #{path}")
  end
end
