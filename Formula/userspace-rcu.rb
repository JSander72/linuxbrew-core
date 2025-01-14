class UserspaceRcu < Formula
  desc "Library for userspace RCU (read-copy-update)"
  homepage "https://liburcu.org"
  url "https://lttng.org/files/urcu/userspace-rcu-0.12.2.tar.bz2"
  sha256 "4eefc11e4f6c212fc7d84d871e1cc139da0669a46ff3fda557a6fdd4d74ca67b"
  license all_of: ["LGPL-2.1-or-later", "MIT"]

  livecheck do
    url "https://lttng.org/files/urcu/"
    regex(/href=.*?userspace-rcu[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "f4fc590ca3038ba37ae1f93f96799139bf99fa4c4ddcf3d1924759385d310203"
    sha256 cellar: :any,                 big_sur:       "2eaf6d663b24932de82d80effcd6bf77fe7307a301296094809495eb4f6c5597"
    sha256 cellar: :any,                 catalina:      "4066d1afdd9ab1bd126c933bcf53bff3d74179195443f272841d9ac5da0b4b05"
    sha256 cellar: :any,                 mojave:        "63d30f6d0d0f00b5eae317aa0cff21f28cfed4a75fd460ba7c6651cc3d3dea79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b46b9b1e42d4f2aa166926ded7f21b083087bd330e208d5b9f3085332103605" # linuxbrew-core
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    cp_r "#{doc}/examples", testpath
    system "make", "CFLAGS=-pthread", "-C", "examples"
  end
end
