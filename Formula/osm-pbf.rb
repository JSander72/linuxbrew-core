class OsmPbf < Formula
  desc "Tools related to PBF (an alternative to XML format)"
  homepage "https://wiki.openstreetmap.org/wiki/PBF_Format"
  url "https://github.com/scrosby/OSM-binary/archive/v1.5.0.tar.gz"
  sha256 "2abf3126729793732c3380763999cc365e51bffda369a008213879a3cd90476c"
  license "LGPL-3.0"
  revision 2

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "45bb201c1bf6e6b4917b61c1cf350d8468f64d5759ed679ab9a0d9827d6d4747"
    sha256 cellar: :any,                 big_sur:       "f0dd295bba1bb4671d2dd4621c0781e1919f1920625a048c71353ed3e077c748"
    sha256 cellar: :any,                 catalina:      "d8ad7c5004b502d94d8e0e2f57376075354844261bd707af422d8fea2923f3e5"
    sha256 cellar: :any,                 mojave:        "5936f90c3c9c6a7ed4a673acb4bf621b213aca053912aff1a3b85f8129879fd4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8f734d0314e89e3ccb8344a87fdea3f707db6472a334b340483f8b4bb411efbb" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "protobuf"

  uses_from_macos "zlib"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    pkgshare.install "resources/sample.pbf"
  end

  test do
    assert_match "OSMHeader", shell_output("#{bin}/osmpbf-outline #{pkgshare}/sample.pbf")
  end
end
