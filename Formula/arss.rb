class Arss < Formula
  desc "Analyze a sound file into a spectrogram"
  homepage "https://arss.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/arss/arss/0.2.3/arss-0.2.3-src.tar.gz"
  sha256 "e2faca8b8a3902226353c4053cd9ab71595eec6ead657b5b44c14b4bef52b2b2"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "0f31b0ca051c5caa089350b30ffd07bed2c24ff2c64dcec6776e19d594b36ad7"
    sha256 cellar: :any, big_sur:       "153a648ed0bdec6e1f0abbdbefff2815b793bf79c4967c803cf55a512228dcfa"
    sha256 cellar: :any, catalina:      "d84220ffc41768520239228b13a8466493682fa30a670163041caa0b06f449a2"
    sha256 cellar: :any, mojave:        "891cda5121a3ea035215f0113d5291fa9afd468e68cc3dc9238b203985fcfe96"
    sha256 cellar: :any, high_sierra:   "b848efa3abde7c5fffd18289c1ab51a842cd93e0e97d6af32329acf869909d38"
    sha256 cellar: :any, sierra:        "2311c31ae2e80905dfc41c8adb9639314664103352540b198f24c54e0c102550"
    sha256 cellar: :any, el_capitan:    "5da45934b19d0cab02c809932fb8c5da3fd76d2f781bc9e2e7a98fa1825989eb"
    sha256 cellar: :any, yosemite:      "268225389842f4952424b17c7b94759b7a3d3009053b50718f1e4155b7eace86"
    sha256 cellar: :any, x86_64_linux:  "7bc019e2012ca8365f5f72677e89d2e3ff80cd4e686b46710fdb2f2693d9c487" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "fftw"

  def install
    cd "src" do
      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/arss", "--version"
  end
end
