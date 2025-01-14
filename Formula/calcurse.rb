class Calcurse < Formula
  desc "Text-based personal organizer"
  homepage "https://calcurse.org/"
  url "https://calcurse.org/files/calcurse-4.7.1.tar.gz"
  sha256 "0a7c55d07674569d166c0b0e7587b2972d3da8160cdb7d60b1dbd2895803afb0"
  license "BSD-2-Clause"

  livecheck do
    url "https://calcurse.org/downloads/"
    regex(/href=.*?calcurse[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "f5aea7fdb9fd90fdbe3ccb695fd1e7922b39bf35b9568a35cca0659aad9884ca"
    sha256 big_sur:       "3ec58ced653c61f7205ee551d5ac6dddeeced2fdd1231c6fc6dae8c1d5532f48"
    sha256 catalina:      "edd3afddbdf8bcd68494332eeb6620a93530cd3a12541fb5db08470422715a4d"
    sha256 mojave:        "3ae0a4b707a783e4fc8be4e575d16701f45f3c69c0cd67b6882e49f86fc7f52f"
    sha256 x86_64_linux:  "bd3d6664580a27bb4569f97ccb207d58fd9edecf6a8443057503f56eed5f24fa" # linuxbrew-core
  end

  head do
    url "https://git.calcurse.org/calcurse.git"

    depends_on "asciidoc" => :build
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "gettext"

  def install
    system "./autogen.sh" if build.head?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    # Specify XML_CATALOG_FILES for asciidoc
    system "make", "XML_CATALOG_FILES=/usr/local/etc/xml/catalog"
    system "make", "install"
  end

  test do
    system bin/"calcurse", "-v"
  end
end
