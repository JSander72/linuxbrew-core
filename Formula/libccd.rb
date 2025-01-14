class Libccd < Formula
  desc "Collision detection between two convex shapes"
  homepage "https://github.com/danfis/libccd"
  url "https://github.com/danfis/libccd/archive/v2.1.tar.gz"
  sha256 "542b6c47f522d581fbf39e51df32c7d1256ac0c626e7c2b41f1040d4b9d50d1e"
  license "BSD-3-Clause"
  revision 1

  bottle do
    sha256 cellar: :any, arm64_big_sur: "69d8c269bc6c5f60d141eaebe6bdff9cf333f789c4d3b72cd69b1e61edff3ea3"
    sha256 cellar: :any, big_sur:       "8257a7f8ab8f5eca8fced2e881b96a68202c08ce94a4aa169d1d80149b61eb0f"
    sha256 cellar: :any, catalina:      "caa0aba8d2ba740998b54c73d3ab038747ac984e4d27797b9f768195a487dc4e"
    sha256 cellar: :any, mojave:        "47c19c5f277ecc9016ef1e62a3ce1a0c4aafd1c91e6893fb4f251183ebd505ec"
    sha256 cellar: :any, x86_64_linux:  "a14bfece67e40f3267b4ea790264ffaefb25c892c7c7d4f13994b07402dfd692" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DENABLE_DOUBLE_PRECISION=ON", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <assert.h>
      #include <ccd/config.h>
      #include <ccd/vec3.h>
      int main() {
      #ifndef CCD_DOUBLE
        assert(false);
      #endif
        ccdVec3PointSegmentDist2(
          ccd_vec3_origin, ccd_vec3_origin,
          ccd_vec3_origin, NULL);
        return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c", "-L#{lib}", "-lccd"
    system "./test"
  end
end
