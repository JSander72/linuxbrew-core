class Walkmod < Formula
  desc "Java-based open source tool to apply and share code conventions"
  homepage "https://walkmod.com/"
  url "https://bitbucket.org/rpau/walkmod/downloads/walkmod-3.0.0-installer.zip"
  sha256 "7d83564b8b11ce02b5a0924e552a8f006524003a03749e5fe901c937cff3d544"
  revision 1

  depends_on "openjdk"

  def install
    # Remove windows files
    rm_f Dir["bin/*.bat"]
    libexec.install Dir["*"]
    (bin/"walkmod").write_env_script libexec/"bin/walkmod", JAVA_HOME: Formula["openjdk"].opt_prefix
  end

  test do
    system "git", "clone", "--depth", "1", "https://github.com/walkmod/walkmod-core.git"
    cd "walkmod-core"
    system bin/"walkmod", "chains"
  end
end
