class LittleCms2 < Formula
  desc "Color management engine supporting ICC profiles"
  homepage "https://www.littlecms.com/"
  # Ensure release is announced at https://www.littlecms.com/categories/releases/
  # (or https://www.littlecms.com/blog/)
  url "https://downloads.sourceforge.net/project/lcms/lcms/2.12/lcms2-2.12.tar.gz"
  sha256 "18663985e864100455ac3e507625c438c3710354d85e5cbb7cd4043e11fe10f5"
  license "MIT"
  version_scheme 1

  # The Little CMS website has been redesigned and there's no longer a
  # "Download" page we can check for releases. As of writing this, checking the
  # "Releases" blog posts seems to be our best option and we just have to hope
  # that the post URLs, headings, etc. maintain a consistent format.
  livecheck do
    url "https://www.littlecms.com/categories/releases/"
    regex(%r{href=.*lcms2[._-]v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "83c79aaa225d6363154151a6b1099bb23ee0c7c1ffed35cb4682b993e047f4a0"
    sha256 cellar: :any,                 big_sur:       "70eaa9b280425731f7dcf104e75d4ae1e6a90421e1a741e0fe82859361c8ae84"
    sha256 cellar: :any,                 catalina:      "0f782fa69d2e12e9c1765df4ae1b7bd87143402aa1840d483092f3b74f89ae19"
    sha256 cellar: :any,                 mojave:        "69af639323557bdd2c09fdaf354d9830441014f98609609146a8c836c752ac10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8844b0b5e0eeb0ef25fe7c057b94e097fbfa97814f02ac7a1b8f1d64a90a3569" # linuxbrew-core
  end

  depends_on "jpeg"
  depends_on "libtiff"

  def install
    args = %W[--disable-dependency-tracking --prefix=#{prefix}]

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/jpgicc", test_fixtures("test.jpg"), "out.jpg"
    assert_predicate testpath/"out.jpg", :exist?
  end
end
