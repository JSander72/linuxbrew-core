class Pdf2json < Formula
  desc "PDF to JSON and XML converter"
  homepage "https://github.com/flexpaper/pdf2json"
  url "https://github.com/flexpaper/pdf2json/archive/0.71.tar.gz"
  sha256 "54878473a2afb568caf2da11d6804cabe0abe505da77584a3f8f52bcd37d9c55"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e648062e7a117f95679cd30c63773085ba2712752450f0b422be8f2fd4d66050"
    sha256 cellar: :any_skip_relocation, big_sur:       "20fe898333fa761b942ee5b0f2d41e47660389a250f5c8604ff1ed22788d9581"
    sha256 cellar: :any_skip_relocation, catalina:      "035c69de85f1cad569ff743faef796a88b9f9a706be802bf111a83505858b366"
    sha256 cellar: :any_skip_relocation, mojave:        "abf950838b700f50ff4279501533176cb5a1929fb0b88c8ccf94b07ac362c66d"
    sha256 cellar: :any_skip_relocation, high_sierra:   "4bee4b8c61362c64d72a3f011f8c5ef223c5e80d269e442a18472adc42e108e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d12d466dbb2fcd6061b2138034e14a81b9dbc241dd1496d9cad2013f036a5f9c" # linuxbrew-core
  end

  def install
    system "./configure"
    system "make", "CC=#{ENV.cc}", "CXX=#{ENV.cxx}"
    bin.install "src/pdf2json"
  end

  test do
    system bin/"pdf2json", test_fixtures("test.pdf"), "test.json"
    assert_predicate testpath/"test.json", :exist?
  end
end
