class Libmpd < Formula
  desc "Higher level access to MPD functions"
  homepage "https://gmpc.fandom.com/wiki/Gnome_Music_Player_Client"
  url "https://www.musicpd.org/download/libmpd/11.8.17/libmpd-11.8.17.tar.gz"
  sha256 "fe20326b0d10641f71c4673fae637bf9222a96e1712f71f170fca2fc34bf7a83"
  revision 1

  livecheck do
    url "https://www.musicpd.org/download/libmpd/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "782e0fccf8dbe605e9fd7740427335d5b7c2340f7506402c17b747560dea4852"
    sha256 cellar: :any, big_sur:       "fcc637b68c3896a2eb9a99aecea990941a8f7fb6ccfcd89c16662d01d5616993"
    sha256 cellar: :any, catalina:      "a89b23f581da1a00a6c9cd077c854bb6b7f1c818664630cec1ed8f0b6f543a32"
    sha256 cellar: :any, mojave:        "9a7f7829ec1d79442d3dade12c338b42a0f248b35aa25475b512f0b70171d8db"
    sha256 cellar: :any, high_sierra:   "2d8f1fae6ecc3ab4b440531ae13a2db5bc82282a89f2670a986cc6136da16068"
    sha256 cellar: :any, sierra:        "8518a3880db71a27a414e8e2ae020afec29afbb777694389cd57d983ec1904a5"
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
