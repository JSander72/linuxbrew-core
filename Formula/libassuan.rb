class Libassuan < Formula
  desc "Assuan IPC Library"
  homepage "https://www.gnupg.org/related_software/libassuan/"
  url "https://gnupg.org/ftp/gcrypt/libassuan/libassuan-2.5.5.tar.bz2"
  mirror "https://www.mirrorservice.org/sites/ftp.gnupg.org/gcrypt/libassuan/libassuan-2.5.5.tar.bz2"
  sha256 "8e8c2fcc982f9ca67dcbb1d95e2dc746b1739a4668bc20b3a3c5be632edb34e4"
  license "GPL-3.0-only"

  livecheck do
    url "https://gnupg.org/ftp/gcrypt/libassuan/"
    regex(/href=.*?libassuan[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "3120a9c83de1631e86002b899ce823abccfd8bcaf90a6f54cbc7cd9ae1fd1fa4"
    sha256 cellar: :any,                 big_sur:       "3d14f187ed48aa40987fa5fdf3ed9cbc52ddf8d079c7e97553efe510e4a084a0"
    sha256 cellar: :any,                 catalina:      "75a37cd9a2f103b1f552349ba537cec0bd2ecbb222583b35e237aa6ad90b84c5"
    sha256 cellar: :any,                 mojave:        "81119eac40ec7e6cfd997631f8d5ed1b6a3646c0b3481acd1c6b98492a187d25"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "99bc4500dfb1c4a606bf2197d9a99b7de82143732238bd5b1bc4460a6763e42d" # linuxbrew-core
  end

  depends_on "libgpg-error"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--enable-static"
    system "make", "install"

    # avoid triggering mandatory rebuilds of software that hard-codes this path
    inreplace bin/"libassuan-config", prefix, opt_prefix
  end

  test do
    system bin/"libassuan-config", "--version"
  end
end
