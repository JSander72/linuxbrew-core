class Duc < Formula
  desc "Suite of tools for inspecting disk usage"
  homepage "https://duc.zevv.nl/"
  url "https://github.com/zevv/duc/releases/download/1.4.4/duc-1.4.4.tar.gz"
  sha256 "f4e7483dbeca4e26b003548f9f850b84ce8859bba90da89c55a7a147636ba922"
  license "LGPL-3.0"
  revision 1
  head "https://github.com/zevv/duc.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "12a17be05c5e063d0ec11c0a7844a88b51ebe89e615310b4e0180ebacfb23bac"
    sha256 cellar: :any,                 big_sur:       "3b8e26bbb5e2356049e0849a889c178a6a89d7137433f5358463bcf188873363"
    sha256 cellar: :any,                 catalina:      "0c6b9ba499943a6523e2618f7d9534892d5eb19250b1d250f9615d6692c64cb8"
    sha256 cellar: :any,                 mojave:        "a6482213346ed6dfb26066b3442722a856cb8348d6123aecfe72929251e6b20a"
    sha256 cellar: :any,                 high_sierra:   "d74b95c03260c0b14fd85e296835047bd88dbbc2f4fd0d62dc3a43409178c18c"
    sha256 cellar: :any,                 sierra:        "9bde89536984080777e870473934584417fb4c34a0e44074b08a07a5db1a98d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5dbb835d37d6eb774f98cce6fcd13e690aa0711183c8435d7dfcfb08445b528a" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "glfw"
  depends_on "pango"
  depends_on "tokyo-cabinet"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--disable-x11",
                          "--enable-opengl"
    system "make", "install"
  end

  test do
    system "dd", "if=/dev/zero", "of=test", "count=1"
    system "#{bin}/duc", "index", "."
    system "#{bin}/duc", "graph", "-o", "duc.png"
    assert_predicate testpath/"duc.png", :exist?, "Failed to create duc.png!"
  end
end
