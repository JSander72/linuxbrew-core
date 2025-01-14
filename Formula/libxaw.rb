class Libxaw < Formula
  desc "X.Org: X Athena Widget Set"
  homepage "https://www.x.org/"
  url "https://www.x.org/archive/individual/lib/libXaw-1.0.14.tar.bz2"
  sha256 "76aef98ea3df92615faec28004b5ce4e5c6855e716fa16de40c32030722a6f8e"
  license "MIT"

  bottle do
    sha256 arm64_big_sur: "6f9bd6bef10340da3fc23f24d0c4a4e3358dcbada118a8b74c4e05d901ac0dd6"
    sha256 big_sur:       "bceab125f7dc2fde90b23c68daf8d3a6b5fff65a0f3f3895abe750a74a328dc6"
    sha256 catalina:      "345ff906f7375ae71a550298fd482c849994ed25d0263822fe7ce8f3740db9f2"
    sha256 mojave:        "16cd8aec41f9df9798704213ac41b7e9013d1a8af9f4bda90bfb13d50e55f057"
    sha256 x86_64_linux:  "9875c977eb0d61612fae17049d42db86ee051398ce885aeb8f7eb3541c4b5894" # linuxbrew-core
  end

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxext"
  depends_on "libxmu"
  depends_on "libxpm"
  depends_on "libxt"

  def install
    args = %W[
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-specs=no
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "X11/Xaw/Text.h"

      int main(int argc, char* argv[]) {
        XawTextScrollMode mode;
        return 0;
      }
    EOS
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
