class Abcl < Formula
  desc "Armed Bear Common Lisp: a full implementation of Common Lisp"
  homepage "https://abcl.org/"
  url "https://abcl.org/releases/1.8.0/abcl-src-1.8.0.tar.gz"
  sha256 "1d871ee2f6bcf991d5a6eff7ea5105ef808610db882604d4df0411e971ad257f"
  license "GPL-2.0-or-later" => {
    with: "Classpath-exception-2.0",
  }
  head "https://abcl.org/svn/trunk/abcl/", using: :svn

  livecheck do
    url "https://abcl.org/releases/"
    regex(%r{href=.*?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "eae344c99094aed9e35305346291d0adf0d6475c4315b6e0f6057b76261952fb"
    sha256 cellar: :any_skip_relocation, big_sur:       "48a45fe17949a01e3164abecfe77a30849cd280faac0233f11a38a216194146a"
    sha256 cellar: :any_skip_relocation, catalina:      "a289f1940cf66e136607417d82ea29ab1df61523f5e6bc6608989c683eba509f"
    sha256 cellar: :any_skip_relocation, mojave:        "69eae372ce01d3e1844747e79ea2dd68763e3997d5bcdbaaf8641fc6f398a23c"
    sha256 cellar: :any_skip_relocation, high_sierra:   "a420b36787e573ecb71a14c9b45780881a25ba7d7897eb79ae74595eab21853d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ef2b48a55f15966c38e3ce109509f92fafc9fbb7b4177dce2cb7b1573e63f72" # linuxbrew-core
  end

  depends_on "ant"
  depends_on "openjdk"
  depends_on "rlwrap"

  def install
    ENV["JAVA_HOME"] = Formula["openjdk"].opt_prefix

    system "ant", "abcl.properties.autoconfigure.openjdk.8"
    system "ant"

    libexec.install "dist/abcl.jar", "dist/abcl-contrib.jar"
    (bin/"abcl").write_env_script "rlwrap",
                                  "java -cp #{libexec}/abcl.jar:\"$CLASSPATH\" org.armedbear.lisp.Main",
                                  Language::Java.overridable_java_home_env
  end

  test do
    (testpath/"test.lisp").write "(print \"Homebrew\")\n(quit)"
    assert_match(/"Homebrew"$/, shell_output("#{bin}/abcl --load test.lisp").strip)
  end
end
