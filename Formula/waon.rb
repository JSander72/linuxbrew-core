class Waon < Formula
  desc "Wave-to-notes transcriber"
  homepage "https://kichiki.github.io/WaoN/"
  url "https://github.com/kichiki/WaoN/archive/v0.11.tar.gz"
  sha256 "75d5c1721632afee55a54bcbba1a444e53b03f4224b03da29317e98aa223c30b"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "5c2460bd2671fbb035d30f61a80c470caca47d2cc2b84b103b1d9d25540dd233"
    sha256 cellar: :any, big_sur:       "1fb554284ace79c0c8eae1d7dc9b9e9ce9d7d90e35e97ad318f5cf7dcdaa059c"
    sha256 cellar: :any, catalina:      "47eaaeeea5b323dced48d444ffc21c2f16b86443271952bceac22abd788ebd8f"
    sha256 cellar: :any, mojave:        "22b3f3cc1a0796db2bf6b808b7157a2e1cacf30b6437998a9f5bdc9482bbfbf8"
    sha256 cellar: :any, high_sierra:   "5c3c49f0740bfcf9d34fd9468af3d9caa8f19c53ee1d25f8d69442d63859c9ab"
    sha256 cellar: :any, sierra:        "d7fd9859544bf3ccb739942f0db00928469356f4d82ab7848cdba2ae5c5e99e9"
    sha256 cellar: :any, el_capitan:    "6f09559eaf287022f280991b44b5f4e86435fafda167c97a78239602183a3758"
    sha256 cellar: :any, yosemite:      "a16c4df918f59a71396d7c4a5806bafe4bda4a89d3aeb2a52d8dfd41ce6c0432"
  end

  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "libsndfile"

  def install
    system "make", "-f", "Makefile.waon", "waon"
    bin.install "waon"
    man1.install "waon.1"
  end

  test do
    system "say", "check one two", "-o", testpath/"test.aiff"
    system "#{bin}/waon", "-i", testpath/"test.aiff", "-o", testpath/"output.midi"
    assert_predicate testpath/"output.midi", :exist?
  end
end
