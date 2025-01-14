class Ipinfo < Formula
  desc "Tool for calculation of IP networks"
  homepage "https://kyberdigi.cz/projects/ipinfo/"
  url "https://kyberdigi.cz/projects/ipinfo/files/ipinfo-1.2.tar.gz"
  sha256 "19e6659f781a48b56062a5527ff463a29c4dcc37624fab912d1dce037b1ddf2d"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c631709cb3810dbbef8f37e1b2d7c76fb301ae36bb9b2d63885ecde62152b7ef"
    sha256 cellar: :any_skip_relocation, big_sur:       "9b70f868f6a9a1c2e59247a09510e14e3da1a45c2acaa86fde9b93a155a14e68"
    sha256 cellar: :any_skip_relocation, catalina:      "b2202f465e419b0bc7e3667d75247cc37a46b49d9a4eb5f23f1f63cb361fd366"
    sha256 cellar: :any_skip_relocation, mojave:        "33fdb805793a8566f7f6adca7a1c3b7d0c67071fc846977bacf6629a8e63c9b2"
    sha256 cellar: :any_skip_relocation, high_sierra:   "c06a0c771b66def2758aad30e8331cc56f751478715e12b25b9e46d9b64090f9"
    sha256 cellar: :any_skip_relocation, sierra:        "255c10eb2f0f885ba301fa2977ae3c45b5f7117388739adb58ce4312515ff98f"
    sha256 cellar: :any_skip_relocation, el_capitan:    "ecb331ae035cf5963afc8e8adf371d80f936960bf0d5ba379b18761263a1b040"
    sha256 cellar: :any_skip_relocation, yosemite:      "e1ce332c726d060521e97a5402746a60778d91beaf28704d9ce5bb6e17451fb3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3ddff03c21a8628ec0bab847802f2bbb5aeb16623b69982220c163d51d1762a" # linuxbrew-core
  end

  conflicts_with "ipinfo-cli", because: "ipinfo and ipinfo-cli install the same binaries"

  def install
    system "make", "BINDIR=#{bin}", "MANDIR=#{man1}", "install"
  end

  test do
    system bin/"ipinfo", "127.0.0.1"
  end
end
