class Hevea < Formula
  desc "LaTeX-to-HTML translator"
  homepage "http://hevea.inria.fr/"
  url "http://hevea.inria.fr/old/hevea-2.35.tar.gz"
  sha256 "f189bada5d3e5b35855dfdfdb5b270c994fc7a2366b01250d761359ad66c9ecb"

  livecheck do
    url "http://hevea.inria.fr/old/"
    regex(/href=.*?hevea[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "83f3e0a6a87ad437058b5bdc840e4663dc1e57b5b34abf32b4f00a72ac436070"
    sha256 big_sur:       "7679aa58989eb2715fad0c5967407ce69b94bc3ec2aa7b3ad9fe7992be315858"
    sha256 catalina:      "6d654577f6c28ddd3c1029df88c7ecfce23dcc3ddac12fba90fc247abfcdb43e"
    sha256 mojave:        "6e0aa3139d0f799090295e989d8aa53d27b6d3735011ee9a8cedd85a0fd3b95b"
    sha256 x86_64_linux:  "a8f174a971457f73152313188b39b40aeac6bc18b529ac0f3a46e4b917e233a3" # linuxbrew-core
  end

  depends_on "ocamlbuild" => :build
  depends_on "ocaml"

  def install
    ENV["PREFIX"] = prefix
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.tex").write <<~EOS
      \\documentclass{article}
      \\begin{document}
      \\end{document}
    EOS
    system "#{bin}/hevea", "test.tex"
  end
end
