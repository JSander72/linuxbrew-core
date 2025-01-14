class Sipp < Formula
  desc "Traffic generator for the SIP protocol"
  homepage "https://sipp.sourceforge.io/"
  url "https://github.com/SIPp/sipp/releases/download/v3.6.1/sipp-3.6.1.tar.gz"
  sha256 "6a560e83aff982f331ddbcadfb3bd530c5896cd5b757dd6eb682133cc860ecb1"
  license "GPL-2.0-or-later"
  revision 1

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "75316a2ff92ad29fb3d2ab4c660f3d4ef2901982826ee269f37a9e58df5cefe2"
    sha256 cellar: :any,                 big_sur:       "4867d847435ee04cf0eccb7e13c27eb93ef8dfe23d8e7aedf5efd702231a4ca4"
    sha256 cellar: :any,                 catalina:      "1744c7e93cab7d3780e4ab24b8d469895ea5086f3f5db6f73a7105e3d784e0fe"
    sha256 cellar: :any,                 mojave:        "0d3578497ed3bce6047dfc90e6d3a4c5b1e80d74b0ff24d3d6d949668ad6e0c1"
  end

  depends_on "cmake" => :build
  depends_on "openssl@1.1"

  uses_from_macos "libpcap"
  uses_from_macos "ncurses"

  def install
    system "cmake", ".", *std_cmake_args, "-DUSE_PCAP=1", "-DUSE_SSL=1"
    system "make", "install"
  end

  test do
    assert_match "SIPp v#{version}", shell_output("#{bin}/sipp -v", 99)
  end
end
