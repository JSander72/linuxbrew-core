class Bloaty < Formula
  desc "Size profiler for binaries"
  homepage "https://github.com/google/bloaty"
  url "https://github.com/google/bloaty/releases/download/v1.1/bloaty-1.1.tar.bz2"
  sha256 "a308d8369d5812aba45982e55e7c3db2ea4780b7496a5455792fb3dcba9abd6f"
  license "Apache-2.0"
  revision 7

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "e712a34c2decedba055e39541fbb78b872ea9e178bed59bf640bcc8e64475280"
    sha256 cellar: :any,                 big_sur:       "b77980ffac7f53ee65fa687673a6121af17ae85abb8f0011043b3be6a45c9aa8"
    sha256 cellar: :any,                 catalina:      "60b53a12e893def4e42d85bfa935dd3b7a2fa6f1bb1d452d13ea5c043f2a5e85"
    sha256 cellar: :any,                 mojave:        "2f604161ef01f1c7d81aad9857bc3b31e74ab726200e0d899dd079b968115e5b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "415639d0dccff820d801c79c631c5a35611edf4b740673a9d1999eaf9f913e94" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "capstone"
  depends_on "protobuf"
  depends_on "re2"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    assert_match(/100\.0%\s+(\d\.)?\d+(M|K)i\s+100\.0%\s+(\d\.)?\d+(M|K)i\s+TOTAL/,
                 shell_output("#{bin}/bloaty #{bin}/bloaty").lines.last)
  end
end
