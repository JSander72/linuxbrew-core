class Aspcud < Formula
  desc "Package dependency solver"
  homepage "https://potassco.org/aspcud/"
  url "https://github.com/potassco/aspcud/archive/v1.9.5.tar.gz"
  sha256 "9cd3a9490d377163d87b16fa1a10cc7254bc2dbb9f60e846961ac8233f3835cf"
  license "MIT"

  bottle do
    sha256 arm64_big_sur: "c984eb4cfd2892c3cca7df260064546275a82fa02c01996ee65ecdf8973f27cb"
    sha256 big_sur:       "c934a46742cb4d96d62a3e15dd9e0ada641672f405b1a96edc3f71dac2c87036"
    sha256 catalina:      "3b19a6ee9f466789d05533e5614ae6daf9cf4abc4e2f6347ad401ea7d4d1040a"
    sha256 mojave:        "b5d0df64bc57c7f929b00f04617f9b1260e7c3715abe68b98559c8b693070add"
    sha256 x86_64_linux:  "d45fb02d4234eda0aa26adcaa4cbc70e74a927d78c0c9186d0415e5ff3c8e451" # linuxbrew-core
  end

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "re2c" => :build
  depends_on "clingo"

  def install
    args = std_cmake_args
    args << "-DASPCUD_GRINGO_PATH=#{Formula["clingo"].opt_bin}/gringo"
    args << "-DASPCUD_CLASP_PATH=#{Formula["clingo"].opt_bin}/clasp"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"in.cudf").write <<~EOS
      package: foo
      version: 1

      request: foo >= 1
    EOS
    system "#{bin}/aspcud", "in.cudf", "out.cudf"
  end
end
