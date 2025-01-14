class LibusbCompat < Formula
  desc "Library for USB device access"
  homepage "https://libusb.info/"
  url "https://downloads.sourceforge.net/project/libusb/libusb-compat-0.1/libusb-compat-0.1.5/libusb-compat-0.1.5.tar.bz2"
  sha256 "404ef4b6b324be79ac1bfb3d839eac860fbc929e6acb1ef88793a6ea328bc55a"
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/libusb-compat[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "8e54f4e98a9dd9e39c8d18e053729472c23a20f35c858fefdc78c8aa6552368f"
    sha256 cellar: :any, big_sur:       "75c7921c73433f1481dfc4aeed5e63dac1a75d67ed13409ed1c2ec053864dadc"
    sha256 cellar: :any, catalina:      "e1f03f77caed5418c50c3c9659e6c56f2363eddfd6cc1aac3f8dcac9451771d2"
    sha256 cellar: :any, mojave:        "11fe66aff70c0177a186c946624f91417565c43bbdc9e7c51725e26ea0c868c5"
    sha256 cellar: :any, high_sierra:   "fccc08c6c3ff2bf93d2aa8e7cc18f30c1fb95fbca044ecaa42d45f7c73a8facf"
    sha256 cellar: :any, sierra:        "e24ad80ee860f6f6c7e6c8dbb100aaa2de3294e2ecf7f591f2f51c52e11f09ea"
    sha256 cellar: :any, el_capitan:    "7b62449f8a9c02834b74adeb0827ca2ae32b47cb82923de0a8e88f16c36ca8b8"
    sha256 cellar: :any, yosemite:      "0e4f131b8fd8210db3ff353a92c35ed12643a717b8780618680e3b4a16d7f347"
    sha256 cellar: :any, x86_64_linux:  "7a27e889da8e809d5c93ce724be81367f69d623849df97c5b894a4b971dd04f1" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/libusb-config", "--libs"
  end
end
