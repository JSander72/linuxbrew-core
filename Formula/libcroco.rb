class Libcroco < Formula
  desc "CSS parsing and manipulation toolkit for GNOME"
  homepage "https://gitlab.gnome.org/GNOME/libcroco"
  url "https://download.gnome.org/sources/libcroco/0.6/libcroco-0.6.13.tar.xz"
  sha256 "767ec234ae7aa684695b3a735548224888132e063f92db585759b422570621d4"
  revision 1

  bottle do
    sha256 cellar: :any, arm64_big_sur: "d6cced1a48822aac65fbb995159f26ed0552217d125969bcae4bd61bdf223407"
    sha256 cellar: :any, big_sur:       "001998f7977aa0e07aa26ab431422e56b2de76dcb7b75dee392f0d0f3674197a"
    sha256 cellar: :any, catalina:      "bc64de8725726ae0188ec23dc9946759565f06e45d3eb10e510d5d42d0888e28"
    sha256 cellar: :any, mojave:        "edf97f493296bfe01b2a8cfe156f1e8052e181bed6ea34cabaf18ed59ef28b17"
    sha256 cellar: :any, high_sierra:   "f6e7d7d608dfcf6e57eaad77eef3cca27c15db0746e102f6dc33cccdd5a8a7bc"
    sha256 cellar: :any, sierra:        "a95e3733bd72b789cc9a3cb9dfc9a92153939b984c4d1d47b8aa806e99e99552"
    sha256 cellar: :any, x86_64_linux:  "41fe29bcc2ada0f0d6812b61f2ab2c3b21f20b16992f81082a65d496e89cd6cd" # linuxbrew-core
  end

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"

  uses_from_macos "libxml2"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-Bsymbolic"
    system "make", "install"
  end

  test do
    (testpath/"test.css").write ".brew-pr { color: green }"
    assert_equal ".brew-pr {\n  color : green\n}",
      shell_output("#{bin}/csslint-0.6 test.css").chomp
  end
end
