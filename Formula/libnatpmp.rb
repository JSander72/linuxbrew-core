class Libnatpmp < Formula
  desc "NAT port mapping protocol library"
  homepage "http://miniupnp.free.fr/libnatpmp.html"
  url "http://miniupnp.free.fr/files/download.php?file=libnatpmp-20150609.tar.gz"
  sha256 "e1aa9c4c4219bc06943d6b2130f664daee213fb262fcb94dd355815b8f4536b0"

  livecheck do
    url "http://miniupnp.free.fr/files/"
    regex(/href=.*?libnatpmp[._-]v?(\d{6,8})\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "748f4fea8075f967191c0f1862c2e20289bee92883c816b191490a35e0d0a9d4"
    sha256 cellar: :any, big_sur:       "b62f39f2cf735ed55841676e6d55473aa1fb5d9247c10151b71184ba20dccba1"
    sha256 cellar: :any, catalina:      "69bd0b362260f89b76113fbfec36235ec6265434c365d18790e8bb1a4988ae67"
    sha256 cellar: :any, mojave:        "1f0e89186c04cd7c7ce9ba88bee87ae31be9c6f5b0ebbcee46f38876d90bfb78"
    sha256 cellar: :any, high_sierra:   "04c286ebb17bf08728749e390dd9ccabf3fcc4b660ffe4b6f315dcf89012f15a"
    sha256 cellar: :any, sierra:        "d1aaa97c827918f7d35d121399cb8f59b4442b94c3283a51b7931f0e008ff934"
    sha256 cellar: :any, el_capitan:    "667fe1a26fdd6e1a36f6e7b263f2f8e3d01f884da9d9edeb182dbb40b08475ab"
    sha256 cellar: :any, x86_64_linux:  "05e5b8a929142a7b6723be3b86c3be5babb36c4fd136866a4b3df7d03b9a64f3" # linuxbrew-core
  end

  def install
    # Reported upstream:
    # https://miniupnp.tuxfamily.org/forum/viewtopic.php?t=978
    inreplace "Makefile", "-Wl,-install_name,$(SONAME)", "-Wl,-install_name,$(INSTALLDIRLIB)/$(SONAME)"
    system "make", "INSTALLPREFIX=#{prefix}", "install"
  end
end
