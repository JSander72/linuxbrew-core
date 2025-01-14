class CmuPocketsphinx < Formula
  desc "Lightweight speech recognition engine for mobile devices"
  homepage "https://cmusphinx.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/0.8/pocketsphinx-0.8.tar.gz"
  sha256 "874c4c083d91c8ff26a2aec250b689e537912ff728923c141c4dac48662cce7a"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(%r{url=.*?/pocketsphinx[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 arm64_big_sur: "4c3fc6b03df2530653a4ff38b270e9a37dd968748b38a011cae6500ab38d8084"
    sha256 big_sur:       "25ce90366420de438c34e8f037f1da3c7ded680375fcc69127cdec7695f84fed"
    sha256 catalina:      "f2fc23a67634f26befdd128d21e886d7b3789484a14d498a40949e0e100d8afa"
    sha256 mojave:        "cc655d82bfce35b2976e4dd0867fceb02b233363e7e101c62b09e60e2be9f8bb"
    sha256 high_sierra:   "628d162751962337c769090867c3f9921d10b09f704f8f208b63abbefef205eb"
    sha256 sierra:        "12abc8b527906e7ed0d2f6f0a6b6cb5c00f548fe94fcce995bdc80f43b4cf17b"
    sha256 el_capitan:    "2f1f4738dbcf7641a530b82c4dc6447ecadb5f9b60cd2484c33c379efb5c46e5"
    sha256 yosemite:      "dea4e6a8e131f68c94a6b9fb783a0445476354a90629001d5007fe3b4e5247bd"
  end

  head do
    url "https://github.com/cmusphinx/pocketsphinx.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "swig" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "cmu-sphinxbase"

  def install
    if build.head?
      ENV["NOCONFIGURE"] = "yes"
      system "./autogen.sh"
    end
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
