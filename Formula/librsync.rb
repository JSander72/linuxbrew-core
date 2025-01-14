class Librsync < Formula
  desc "Library that implements the rsync remote-delta algorithm"
  homepage "https://librsync.github.io/"
  url "https://github.com/librsync/librsync/archive/v2.3.2.tar.gz"
  sha256 "ef8ce23df38d5076d25510baa2cabedffbe0af460d887d86c2413a1c2b0c676f"
  license "LGPL-2.1-or-later"

  bottle do
    sha256                               arm64_big_sur: "e2672691faeaba727acde6252c3dba8a39b9a0703f942f8f830d6e5514e15bb3"
    sha256                               big_sur:       "7561cdbc8327f77db0647112ae1496ca544c659a04dfe83e703c9edeee890869"
    sha256                               catalina:      "4d38d5dbea74b9eac4624877d7c7e29f08c38d68dedaaf9dadbdc5e3a820678b"
    sha256                               mojave:        "5796b96a6fc4781e134879993d0fa23816994c424d9984ec0584ae6b0bea2963"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1b7207e1c3725cb55b51c0711c0a6d583d4f3f55e11c6aee68649e0a94f0ae8" # linuxbrew-core
  end

  depends_on "cmake" => :build
  depends_on "popt"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    man1.install "doc/rdiff.1"
    man3.install "doc/librsync.3"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rdiff -V")
  end
end
