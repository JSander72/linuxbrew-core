class ClosureStylesheets < Formula
  desc "Extended CSS preprocessor, linter, and internationalizer"
  homepage "https://github.com/google/closure-stylesheets"
  url "https://github.com/google/closure-stylesheets/releases/download/v1.5.0/closure-stylesheets.jar"
  sha256 "aa4e9b23093187a507a4560d13e59411fc92e285bc911b908a6bcf39479df03c"
  license "Apache-2.0"
  revision 1

  depends_on "openjdk"

  def install
    libexec.install "closure-stylesheets.jar"
    (bin/"closure-stylesheets").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk"].opt_bin}/java" -jar "#{libexec}/closure-stylesheets.jar" "$@"
    EOS
  end

  test do
    (testpath/"test.gss").write <<~EOS
      @def A 5px;
      @def B 10px;
      .test {
        width: add(A, B);
      }
    EOS
    system bin/"closure-stylesheets", testpath/"test.gss", "-o", testpath/"out.css"
    assert_equal (testpath/"out.css").read.chomp, ".test{width:15px}"
  end
end
