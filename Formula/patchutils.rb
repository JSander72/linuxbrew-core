class Patchutils < Formula
  desc "Small collection of programs that operate on patch files"
  homepage "http://cyberelk.net/tim/software/patchutils/"
  url "http://cyberelk.net/tim/data/patchutils/stable/patchutils-0.4.2.tar.xz"
  mirror "https://deb.debian.org/debian/pool/main/p/patchutils/patchutils_0.4.2.orig.tar.xz"
  sha256 "8875b0965fe33de62b890f6cd793be7fafe41a4e552edbf641f1fed5ebbf45ed"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "cc5cba6808061043a4275dfff1ffbc9dfc623b604bd80df87731302d24d9e8a7"
    sha256 cellar: :any_skip_relocation, big_sur:       "2305540f050f688ecb19afbd61daaee0dc51cf27d43cd2baff3e8542ea631680"
    sha256 cellar: :any_skip_relocation, catalina:      "3ee4d0c62b3f2b26e28fbf476c37eaeb8ccca9000c4f8f2766cd2c662de855bc"
    sha256 cellar: :any_skip_relocation, mojave:        "12cd388801c5c628db409cb043d6a2fc436f44ae8f01a754f430763380043af4"
    sha256 cellar: :any_skip_relocation, high_sierra:   "84b5013e7c6647e1cda9faa1ab9b31834ed6e2ef6c1a48d21ab7c459dc4462b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d0a114819b0971bab6726f15c1de5098425df8618bf6ae9105c32f87767f1599" # linuxbrew-core
  end

  head do
    url "https://github.com/twaugh/patchutils.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "docbook" => :build
  end

  depends_on "xmlto" => :build

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog" if build.head?
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match %r{a/libexec/NOOP}, shell_output("#{bin}/lsdiff #{test_fixtures("test.diff")}")
  end
end
