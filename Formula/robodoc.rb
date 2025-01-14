class Robodoc < Formula
  desc "Source code documentation tool"
  homepage "https://rfsber.home.xs4all.nl/Robo/index.html"
  url "https://rfsber.home.xs4all.nl/Robo/archives/robodoc-4.99.44.tar.bz2"
  sha256 "3721c3be9668a1503454618ed807ae0fba5068b15bc0ea63846787d7e9e78c0f"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://rfsber.home.xs4all.nl/Robo/archives/"
    regex(/href=.*?robodoc[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "4dddc1a534d6c0e60601403b9272f84cb14ce2e665e6882b9609b6f7db27d981"
    sha256 big_sur:       "72127c3a10a58f3a4d1c5eaaae50c33944063d3fe10eb71a95f17c7c32635d44"
    sha256 catalina:      "8c02f006c5ef0639855d20c284bdc9ce03f2e4ad11e6d4659a75f3080e815abf"
    sha256 mojave:        "f6cf96a433e670f0e92079848d45062fc93da258c3bda2749464aedb9bffc1f9"
    sha256 x86_64_linux:  "e68fb7af579d76454292fdcaa5d7f47db9af0ae1c0905ca735f02a2e75ebf239" # linuxbrew-core
  end

  head do
    url "https://github.com/gumpu/ROBODoc.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "autoreconf", "-f", "-i" if build.head?
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make", "install"
  end

  test do
    cp_r Dir["#{doc}/Examples/PerlExample/*"], testpath
    system bin/"robodoc"
  end
end
