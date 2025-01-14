class Xpa < Formula
  desc "Seamless communication between Unix programs"
  homepage "https://hea-www.harvard.edu/RD/xpa/"
  url "https://github.com/ericmandel/xpa/archive/2.1.20.tar.gz"
  sha256 "854af367c0f4ffe7a65cb4da854a624e20af3c529f88187b50b22b68f024786a"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6b22cf494e2ca55efce9a08463ddd9ef4044af0a479689aa5ab610e40465fc93"
    sha256 cellar: :any_skip_relocation, big_sur:       "025fa588033850451ca384e0274dd96d29c6e9e1331fd09aa82aad0bb2289af5"
    sha256 cellar: :any_skip_relocation, catalina:      "223dc44eba3ff66b59c26e53e9d0ab14c63d57e2f76786bae9fdb7a2be5bbdac"
    sha256 cellar: :any_skip_relocation, mojave:        "6ba46da9e3de8719db32f1f577fb6943be03a58f8c6472ef7f9b398d0fea9743"
    sha256 cellar: :any_skip_relocation, high_sierra:   "686a14717f6ae1b2af6230c3568622f9a480f8884cfee0924ffbecbee8b33db9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de7aa1e62ff69999a473253e9589e493959ca8fbd7914ca2e38a5e14f51f9dc3" # linuxbrew-core
  end

  depends_on "libxt" => :build

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    # relocate man, since --mandir is ignored
    mv "#{prefix}/man", man
  end
end
