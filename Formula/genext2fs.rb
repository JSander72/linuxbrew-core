class Genext2fs < Formula
  desc "Generates an ext2 filesystem as a normal (non-root) user"
  homepage "https://genext2fs.sourceforge.io/"
  url "https://github.com/bestouff/genext2fs/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "d3861e4fe89131bd21fbd25cf0b683b727b5c030c4c336fadcd738ada830aab0"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c0956842c6c717a7dd0b96d16a569700005d5863da8a78ce0eb281562fb5a664"
    sha256 cellar: :any_skip_relocation, big_sur:       "73555ddf605c31d1ab998686f18291bb857bf0194e46b14ee6c42232d74d857c"
    sha256 cellar: :any_skip_relocation, catalina:      "2223acb79fe730270f9dea81b2835d5fa72c099c91e817fb502d22ecb6b974df"
    sha256 cellar: :any_skip_relocation, mojave:        "2523dcf597e5caa415a2be9a0a4b2ab472b573326bfbb894ce5983427a0419d0"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    rootpath = testpath/"img"
    (rootpath/"foo.txt").write "hello world"
    system "#{bin}/genext2fs", "--root", rootpath,
                               "--block-size", "4096",
                               "--size-in-blocks", "100",
                               "#{testpath}/test.img"
  end
end
