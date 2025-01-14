class Libebml < Formula
  desc "Sort of a sbinary version of XML"
  homepage "https://www.matroska.org/"
  license "LGPL-2.1-or-later"
  revision 2 unless OS.mac?
  head "https://github.com/Matroska-Org/libebml.git"

  # Remove stable block in next release with merged patch
  stable do
    url "https://dl.matroska.org/downloads/libebml/libebml-1.4.2.tar.xz"
    sha256 "41c7237ce05828fb220f62086018b080af4db4bb142f31bec0022c925889b9f2"

    # Fix compilation with GCC: error: 'numeric_limits' is not a member of 'std'
    # Ported from https://github.com/Matroska-Org/libebml/commit/f0bfd53647961e799a43d918c46cf3b6bff89806
    # Remove in the next release
    patch :DATA
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "fce6d01b12243501223e4e9294528b8eab1818815b18e4ffe777fd14cec0e525"
    sha256 cellar: :any,                 big_sur:       "de4edaae6d3f42a388be996f448b582262e39e923acc9ccef881a20ffa817d38"
    sha256 cellar: :any,                 catalina:      "20a71bb0c2babdc04f179dc77c7a03c2f2f2031e7d8d87fbf9d3c41ee831addc"
    sha256 cellar: :any,                 mojave:        "c3c91dc9f86978012a06f299115bc088e5ea0af6aec2e915d0f8338c4c0edd03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1fc990bad774ee2d7ce5d0794effee2529fbd31932854f2a6aa444d8634ce821" # linuxbrew-core
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "gcc" => :build
  end

  fails_with gcc: "5"

  def install
    mkdir "build" do
      system "cmake", "..", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
      system "make", "install"
    end
  end
end

__END__
diff --git a/src/EbmlString.cpp b/src/EbmlString.cpp
index 27e55fdf6c98c52ab73c8f02d8c69e31505f93d7..4c05fcfea34988672f2d7084f34e874a6c99cfdc 100644
--- a/src/EbmlString.cpp
+++ b/src/EbmlString.cpp
@@ -34,6 +34,7 @@
   \author Steve Lhomme     <robux4 @ users.sf.net>
 */
 #include <cassert>
+#include <limits>
 
 #include "ebml/EbmlString.h"
 
diff --git a/src/EbmlUnicodeString.cpp b/src/EbmlUnicodeString.cpp
index 496a16acc293487e842bc5696b1fe2f93c204a12..99fc073776d228692475997fba9a5be3280ffc99 100644
--- a/src/EbmlUnicodeString.cpp
+++ b/src/EbmlUnicodeString.cpp
@@ -36,6 +36,7 @@
 */
 
 #include <cassert>
+#include <limits>
 
 #include "ebml/EbmlUnicodeString.h"
 
