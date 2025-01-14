class Mozjpeg < Formula
  desc "Improved JPEG encoder"
  homepage "https://github.com/mozilla/mozjpeg"
  url "https://github.com/mozilla/mozjpeg/archive/v4.0.3.tar.gz"
  sha256 "4f22731db2afa14531a5bf2633d8af79ca5cb697a550f678bf43f24e5e409ef0"
  license "BSD-3-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256                               arm64_big_sur: "43d05f184bc2c2f0451913c9d6a437dd597c9da0fc675fd6a96859face7d8819"
    sha256                               big_sur:       "62b7cba57dec06208ee2af6a726b918c0131c0d4f4b735d32eab16df348e1852"
    sha256                               catalina:      "0664824dab3ebe497562d4b9fcb1fdafd011d7f0bcd6d50dc60bd73db57168cc"
    sha256                               mojave:        "0188f192ba8d6471e034d8144b321a84871d46cf110fb27bdebb67f2d9116baa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5ada6a768a14983ee538c858b28c23262d287f1d6cf20694fe38bad9fa0aa94d" # linuxbrew-core
  end

  keg_only "mozjpeg is not linked to prevent conflicts with the standard libjpeg"

  depends_on "cmake" => :build
  depends_on "nasm" => :build
  depends_on "libpng"

  def install
    mkdir "build" do
      args = std_cmake_args - %w[-DCMAKE_INSTALL_LIBDIR=lib]
      system "cmake", "..", *args, "-DCMAKE_INSTALL_LIBDIR=#{lib}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system bin/"jpegtran", "-crop", "1x1",
                           "-transpose", "-optimize",
                           "-outfile", "out.jpg",
                           test_fixtures("test.jpg")
  end
end
