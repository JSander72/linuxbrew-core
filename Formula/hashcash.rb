class Hashcash < Formula
  desc "Proof-of-work algorithm to counter denial-of-service (DoS) attacks"
  homepage "http://hashcash.org"
  url "http://hashcash.org/source/hashcash-1.22.tgz"
  sha256 "0192f12d41ce4848e60384398c5ff83579b55710601c7bffe6c88bc56b547896"

  livecheck do
    url "http://hashcash.org/source/"
    regex(/href=.*?hashcash[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a58aab9f64cd4e97938df6d17e88f8d07549d9d84d3499e0c2d071664660132c"
    sha256 cellar: :any_skip_relocation, big_sur:       "4d72206542ef1e5c627cd54327baa1fa5b5c669445ba4879aac6dbe4c23876a3"
    sha256 cellar: :any_skip_relocation, catalina:      "1865d8db05d392b73cf26b0d873b397b087ac76f6a71c6bdbbf9f5888d46ef15"
    sha256 cellar: :any_skip_relocation, mojave:        "775184aba3e61dcabed2020c4f2bdda029561badd41aae6d75c56b7bb564a7a3"
    sha256 cellar: :any_skip_relocation, high_sierra:   "acb58644b209a262a1f8aea8c4f40e078f4e76742d0339c4e240f92bdd2fb290"
    sha256 cellar: :any_skip_relocation, sierra:        "af78a79c6b0dbf5267781eb209cc3115f43dcdfd7a389c2740262bbab3be3c20"
    sha256 cellar: :any_skip_relocation, el_capitan:    "b9ab067b3001c71dc5cfa3085bfcd204cb4837fd6c87f5ce722bd77b8a629850"
    sha256 cellar: :any_skip_relocation, yosemite:      "b9e7653e9f2c14aad3d4f3589bed6de036e78b766bc01be5ae9f24be0d9696c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5f36d00d696205be5f23cf4bd7968c7fa07f0d4375d00ef5ead2f5232ffcbb1e" # linuxbrew-core
  end

  def install
    system "make", "install",
                   "PACKAGER=HOMEBREW",
                   "INSTALL_PATH=#{bin}",
                   "MAN_INSTALL_PATH=#{man1}",
                   "DOC_INSTALL_PATH=#{doc}"
  end

  test do
    system "#{bin}/hashcash", "-mb10", "test@example.com"
  end
end
