class Libgfshare < Formula
  desc "Library for sharing secrets"
  homepage "https://www.digital-scurf.org/software/libgfshare"
  url "https://www.digital-scurf.org/files/libgfshare/libgfshare-2.0.0.tar.bz2"
  sha256 "86f602860133c828356b7cf7b8c319ba9b27adf70a624fe32275ba1ed268331f"

  bottle do
    sha256 cellar: :any, arm64_big_sur: "d8fc2d9c78a69fc3fe30913aeaa6f1dbeea7091d78d50bd6e6fafcf4dc6dc212"
    sha256 cellar: :any, big_sur:       "619b6bee51163d432b903899d6d86223824e055124ead1856bc6c4399fef4fca"
    sha256 cellar: :any, catalina:      "59d6afbdff08b3b457ae3bf6284859eb200929dbcf38c7a2e4f6025a45fe02dc"
    sha256 cellar: :any, mojave:        "23c584fb3f3edcb9516beacb9cc3448c6bd2352ce44063e609d7a3e9aaeadd34"
    sha256 cellar: :any, high_sierra:   "0079ff7fef137a59579eb12e9f15087573ad2c19c8d7a4d53e2a7d8d378e6af1"
    sha256 cellar: :any, sierra:        "ed8e772e5d4b6c8471aa4d711bd2178b873cce23028bcd3831a51aca67c3485e"
    sha256 cellar: :any, el_capitan:    "c50ebaadca206eef93bc6d835f5814e0d640223c2c7e39cd12feff47720c054d"
    sha256 cellar: :any, yosemite:      "6929a937f6f8ee624f02891622375d23aa65114475cf53ce82342976b4705454"
    sha256 cellar: :any, x86_64_linux:  "5fcea5e75446540a94c30a1ca71d9bd2c514ce94e750c26725b538754e93d242" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-linker-optimisations",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    touch "test.in"
    system "#{bin}/gfsplit", "test.in"
    system "#{bin}/gfcombine test.in.*"
  end
end
