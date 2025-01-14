class Yajl < Formula
  desc "Yet Another JSON Library"
  homepage "https://lloyd.github.io/yajl/"
  url "https://github.com/lloyd/yajl/archive/2.1.0.tar.gz"
  sha256 "3fb73364a5a30efe615046d07e6db9d09fd2b41c763c5f7d3bfb121cd5c5ac5a"
  license "ISC"

  bottle do
    rebuild 4
    sha256 cellar: :any, arm64_big_sur: "baefc7dc955217c4bdefd8dc798a6ad432131f449370a6249e31be6604842942"
    sha256 cellar: :any, big_sur:       "18bd8c54e847441959876cc9580db5ddcb7e3b92f2fc37ca49ce27d17c050df3"
    sha256 cellar: :any, catalina:      "65975afbeddbbd919282c04e53fccda191501eb4fa8992a2b4ab1b2be2e10151"
    sha256 cellar: :any, mojave:        "ab562be70a8ff64861d52b170585f52af91a275e6b5974241eaabd0997b990f2"
    sha256 cellar: :any, high_sierra:   "3213f11462b3c60a33209c4f5d36c96caf1a9409103012ffb427dd51770ac120"
    sha256 cellar: :any, sierra:        "1f97e0bbc6680ad4735f0c7ecac20ec87531456c3ab1c93c480c5c5a93a33e1c"
    sha256 cellar: :any, el_capitan:    "5cfd83bfdbd7c92402f1cecc6b66788e6db0c195880a40263365d8130e47db2f"
    sha256 cellar: :any, yosemite:      "600fec6352ac23a66795cce22cb0a555df43eb464c87693299cb4fc2a1307833"
    sha256 cellar: :any, x86_64_linux:  "f0c23a3d9a441a2d01237278c5c0a2b027397534ffc397403db8160b775ad695" # linuxbrew-core
  end

  # Configure uses cmake internally
  depends_on "cmake" => :build

  def install
    ENV.deparallelize

    system "cmake", ".", *std_cmake_args
    system "make", "install"
    (include/"yajl").install Dir["src/api/*.h"]
  end

  test do
    output = pipe_output("#{bin}/json_verify", "[0,1,2,3]").strip
    assert_equal "JSON is valid", output
  end
end
