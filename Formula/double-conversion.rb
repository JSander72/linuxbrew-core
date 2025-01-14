class DoubleConversion < Formula
  desc "Binary-decimal and decimal-binary routines for IEEE doubles"
  homepage "https://github.com/google/double-conversion"
  url "https://github.com/google/double-conversion/archive/v3.1.5.tar.gz"
  sha256 "a63ecb93182134ba4293fd5f22d6e08ca417caafa244afaa751cbfddf6415b13"
  license "BSD-3-Clause"
  revision OS.mac? ? 1 : 2
  head "https://github.com/google/double-conversion.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "928fbd4a31967ec090b4b292b1a212fec7eb75f27443493d0c175ca8bb56a9dc"
    sha256 cellar: :any_skip_relocation, big_sur:       "0f7c08daace9fc854f8526a7699102f40de9898fa1e6b05a0199b5da3c9e1a7d"
    sha256 cellar: :any_skip_relocation, catalina:      "20b93e20891d48912ffbfbdf3ef470f7305684df2381ef93056a11cedd95c65f"
    sha256 cellar: :any_skip_relocation, mojave:        "ec700c89a4f1794170b4466f5a0a100b6eafee7cb0a794e55ea53de18114a1d3"
    sha256 cellar: :any_skip_relocation, high_sierra:   "9b54153b09683b8fa40160588792385e04f6be56ba355c5a530a2209b9f0526d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "96604a8a62a29b5a5bda15a7b1181d76c0b32f3c5006c9530d8e1f50c548fe0f" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    mkdir "dc-build" do
      system "cmake", "..", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
      system "make", "install"
      system "make", "clean"

      system "cmake", "..", "-DBUILD_SHARED_LIBS=OFF", *std_cmake_args
      system "make"
      lib.install "libdouble-conversion.a"
    end
  end

  test do
    (testpath/"test.cc").write <<~EOS
      #include <double-conversion/bignum.h>
      #include <stdio.h>
      int main() {
          char buf[20] = {0};
          double_conversion::Bignum bn;
          bn.AssignUInt64(0x1234567890abcdef);
          bn.ToHexString(buf, sizeof buf);
          printf("%s", buf);
          return 0;
      }
    EOS
    system ENV.cc, "test.cc", "-L#{lib}", "-ldouble-conversion", "-o", "test"
    assert_equal "1234567890ABCDEF", `./test`
  end
end
