class Acme < Formula
  desc "Crossassembler for multiple environments"
  homepage "https://sourceforge.net/projects/acme-crossass/"
  url "https://svn.code.sf.net/p/acme-crossass/code-0/trunk", revision: "266"
  version "0.97"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://sourceforge.net/p/acme-crossass/code-0/HEAD/tree/trunk/docs/Changes.txt?format=raw"
    strategy :page_match
    regex(/New in release v?(\d+(?:\.\d+)+)/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "eed2df7b934a52ca875e02a7b89588ac602cfa0cfbde0e795bbcdaff72bb5201"
    sha256 cellar: :any_skip_relocation, big_sur:       "7890b8c1a32b202ab913553d534db373de3d61bb274a564fb9304cd4de043736"
    sha256 cellar: :any_skip_relocation, catalina:      "54080f9a08a3f958c5a024fd536c2308c392521a4a4092afb115f368b3256fd2"
    sha256 cellar: :any_skip_relocation, mojave:        "53ddd3c05dea30a12436e997a68ab50670bd9dbe771e3c3a6d7216c0240c6e07"
    sha256 cellar: :any_skip_relocation, high_sierra:   "8ed3df0ed73b3f995ca33b357c00f54b03f16ec2effd61eca985b04a82eb40b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a3af8c9c37300596a51cceda52651cd76900d16afbf81917c59bf947dd12ae9d" # linuxbrew-core
  end

  def install
    system "make", "-C", "src", "install", "BINDIR=#{bin}"
    doc.install Dir["docs/*"]
  end

  test do
    path = testpath/"a.asm"
    path.write <<~EOS
      !to "a.out", cbm
      * = $c000
      jmp $fce2
    EOS

    system bin/"acme", path
    code = File.open(testpath/"a.out", "rb") { |f| f.read.unpack("C*") }
    assert_equal [0x00, 0xc0, 0x4c, 0xe2, 0xfc], code
  end
end
