class Quickjs < Formula
  desc "Small and embeddable JavaScript engine"
  homepage "https://bellard.org/quickjs/"
  url "https://bellard.org/quickjs/quickjs-2021-03-27.tar.xz"
  sha256 "a45bface4c3379538dea8533878d694e289330488ea7028b105f72572fe7fe1a"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?quickjs[._-]v?(\d+(?:[.-]\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "c6fe0bfcc35db87914873424e1a7d4386362eeb008ef1fb28e78cd87811bbb14"
    sha256 big_sur:       "fe0f2ea5d5afcdf52bd8fc70277f27b39e00aeda8229bcb2d59d01a8454704ca"
    sha256 catalina:      "ec26dd8206150e0f19102256a47a77c4373b61ba9a91981050a6fa000f010284"
    sha256 mojave:        "de7929242e69797033d62921e1605c67890e5dbe13f05cd09e01724962d12624"
    sha256 x86_64_linux:  "0ffbbe7d66543994d2ec21a6b26edcae6c43e297be4c29a067b3972c75b606a9" # linuxbrew-core
  end

  def install
    system "make", "install", "prefix=#{prefix}", "CONFIG_M32="
  end

  test do
    output = shell_output("#{bin}/qjs --eval 'const js=\"JS\"; console.log(`Q${js}${(7 + 35)}`);'").strip
    assert_match(/^QJS42/, output)

    path = testpath/"test.js"
    path.write "console.log('hello');"
    system "#{bin}/qjsc", path
    output = shell_output(testpath/"a.out").strip
    assert_equal "hello", output
  end
end
