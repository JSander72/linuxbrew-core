class Laszip < Formula
  desc "Lossless LiDAR compression"
  homepage "https://laszip.org/"
  url "https://github.com/LASzip/LASzip/releases/download/3.4.3/laszip-src-3.4.3.tar.gz"
  sha256 "53f546a7f06fc969b38d1d71cceb1862b4fc2c4a0965191a0eee81a57c7b373d"
  license "LGPL-2.1-or-later"
  head "https://github.com/LASzip/LASzip.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6849693f9166120961fcada7af8d222c1e7580bc191d75a3fdef7ca685f22566"
    sha256 cellar: :any_skip_relocation, big_sur:       "3b8bf75cb5a0c7f2ac6b02c59726b9b2d126ac754dc24a45ffff3adb18bc1a15"
    sha256 cellar: :any_skip_relocation, catalina:      "df73f3c2c8be13bc0fab13f28cbb22262a24c283f4da85cf6b21c55531516e7f"
    sha256 cellar: :any_skip_relocation, mojave:        "3a9bc6d5931145800cb5792740a3cae118d27c4879144f3c74a44c2aee75ce64"
    sha256 cellar: :any_skip_relocation, high_sierra:   "a32459a4896bdc365fae55b70744bb7ae2a05b552e3bb0b0097345e0ea423014"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "15fa5ef57a5b86446e6d9e21fe1cab535d2716ec703864f347fce124f8e8ee0e" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "example"
  end

  test do
    system ENV.cxx, pkgshare/"example/laszipdllexample.cpp", "-L#{lib}",
                    "-llaszip", "-llaszip_api", "-Wno-format", "-ldl", "-o", "test"
    assert_match "LASzip DLL", shell_output("./test -h 2>&1", 1)
  end
end
