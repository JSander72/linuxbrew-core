class GitCrypt < Formula
  desc "Enable transparent encryption/decryption of files in a git repo"
  homepage "https://www.agwa.name/projects/git-crypt/"
  url "https://www.agwa.name/projects/git-crypt/downloads/git-crypt-0.6.0.tar.gz"
  sha256 "6d30fcd99442d50f4b3c8d554067ff1d980cdf9f3120ee774131172dba98fd6f"
  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?git-crypt[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "b30c2ac4ab305cc72b8be7253b7bf3dcca3487a579ebf00e21da793d4afc8bd4"
    sha256 cellar: :any, big_sur:       "7567932a504ce3c08a087f9d3d020f5ca8307f41fe2a16a843e7df862120abc9"
    sha256 cellar: :any, catalina:      "f38bb645c3eff62cfb43802199370d85e4785fcf10c063e4d7453e032788bcba"
    sha256 cellar: :any, mojave:        "89d2058a4dd5afc565696707c8e93621fd644f9ab303fe378727ae999783d156"
    sha256 cellar: :any, high_sierra:   "0d2cf3c93ab2ca4059163f8da8a3ab845b566b13debf5e1b43a734dc86138a18"
    sha256 cellar: :any, sierra:        "6b2c2773e5c327282d461f5d49600928ae97d432e5f4d8b7acfcaaa6e6d1ef68"
    sha256 cellar: :any, x86_64_linux:  "372004fabdc4dd18a4fb615f9b4619e4cc64665e39b3303c6b417b7d3a5c2d78" # linuxbrew-core
  end

  depends_on "openssl@1.1"

  def install
    system "make"
    bin.install "git-crypt"
  end

  test do
    system "#{bin}/git-crypt", "keygen", "keyfile"
  end
end
