class GoogleSparsehash < Formula
  desc "Extremely memory-efficient hash_map implementation"
  homepage "https://github.com/sparsehash/sparsehash"
  url "https://github.com/sparsehash/sparsehash/archive/sparsehash-2.0.4.tar.gz"
  sha256 "8cd1a95827dfd8270927894eb77f62b4087735cbede953884647f16c521c7e58"
  license "BSD-3-Clause"
  head "https://github.com/sparsehash/sparsehash.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f24d74610bacd7a53f950e58f03b6d674d43a15495973d09c006e44e6721fde8"
    sha256 cellar: :any_skip_relocation, big_sur:       "530dad7aa78d4420bbcbe5dbd6ab1a634acbc29a22576f19ec31af556ed4332c"
    sha256 cellar: :any_skip_relocation, catalina:      "11390608ee72647c06a9735f89535604e6ed2b2531431f9eb81bdf423ab07620"
    sha256 cellar: :any_skip_relocation, mojave:        "11390608ee72647c06a9735f89535604e6ed2b2531431f9eb81bdf423ab07620"
    sha256 cellar: :any_skip_relocation, high_sierra:   "11390608ee72647c06a9735f89535604e6ed2b2531431f9eb81bdf423ab07620"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1709e2d51da956b758bd38137c2010cc3dd30f05d9985d6c9f607c31f72d5613" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
  end
end
