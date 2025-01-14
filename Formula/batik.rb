class Batik < Formula
  desc "Java-based toolkit for SVG images"
  homepage "https://xmlgraphics.apache.org/batik/"
  url "https://www.apache.org/dyn/closer.lua?path=xmlgraphics/batik/binaries/batik-bin-1.14.tar.gz"
  mirror "https://archive.apache.org/dist/xmlgraphics/batik/binaries/batik-bin-1.14.tar.gz"
  sha256 "0f4eaa81be70752e406a19f39c39c018848f09963f08fa8974640547052c4618"
  license "Apache-2.0"

  depends_on "openjdk"

  def install
    libexec.install "lib", Dir["*.jar"]
    Dir[libexec/"*.jar"].each do |f|
      bin.write_jar_script f, File.basename(f, "-#{version}.jar")
    end
  end

  test do
    font_name = (MacOS.version >= :catalina) ? "Arial Unicode.ttf" : "Arial.ttf"
    system bin/"batik-ttf2svg", "/Library/Fonts/#{font_name}", "-autorange",
           "-o", "Arial.svg", "-testcard"
    assert_match "abcdefghijklmnopqrstuvwxyz", File.read("Arial.svg")
  end
end
