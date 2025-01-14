class Octomap < Formula
  desc "Efficient probabilistic 3D mapping framework based on octrees"
  homepage "https://octomap.github.io/"
  url "https://github.com/OctoMap/octomap/archive/v1.9.7.tar.gz"
  sha256 "3e9ac020686ceb4e17e161bffc5a0dafd9cccab33adeb9adee59a61c418ea1c1"
  license "BSD-3-Clause"

  bottle do
    sha256                               arm64_big_sur: "80ee7ff92e3207223ab883c128606951c9e570909faa586c7b40b22838959332"
    sha256                               big_sur:       "476b64c7554e93e2f14955fb5d0063bddfc097cb5bcef1e06ffc934e182fff2c"
    sha256                               catalina:      "de360e7e0e3d6ec32157a5efe614481a077913b80540eca1f3dfc65f0c32bf80"
    sha256                               mojave:        "2108b9e2a70a4e8f2eb6581ff525570d83eb7a603f4af0cb69c2d9caeb5c16b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c1d8649f77df789d363e6ac9a3e06281c755fef1ff63b400eff264ee8311d16" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    cd "octomap" do
      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <cassert>
      #include <octomap/octomap.h>
      int main() {
        octomap::OcTree tree(0.05);
        assert(tree.size() == 0);
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}",
                    "-loctomath", "-loctomap", "-o", "test"
    system "./test"
  end
end
