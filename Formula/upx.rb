class Upx < Formula
  desc "Compress/expand executable files"
  homepage "https://upx.github.io/"
  url "https://github.com/upx/upx/releases/download/v3.96/upx-3.96-src.tar.xz"
  sha256 "47774df5c958f2868ef550fb258b97c73272cb1f44fe776b798e393465993714"
  revision 1
  head "https://github.com/upx/upx.git", branch: "devel"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "5fc54db6b0fb2e8ebfa630d48c893e569e49b5c6795646d8912c447f3b0a1747"
    sha256 cellar: :any_skip_relocation, catalina:     "c04d7040eeaa8d2842449b86789ece0f0a73ee0ac1c013c6a00596288251abbc"
    sha256 cellar: :any_skip_relocation, mojave:       "a2253a74b3531dc9173eac2ae2ea816ff7b8af3657aee2180ca1253f49cd9fec"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e34d2d57d52fb4cd406d690b891b8549a9309246b114ec8fa6797aa7b7e0a7b2" # linuxbrew-core
  end

  depends_on "ucl" => :build

  uses_from_macos "zlib"

  patch do
    # Big Sur fix: https://github.com/upx/upx/issues/424
    url "https://github.com/upx/upx/commit/51f69a20e0287904398bbf4c72ba2f809a0b0850.patch?full_index=1"
    sha256 "2f311ce1e7254085817d3415a687d561f761fb3a2077f0605fc3f39e620485f0"
  end

  def install
    system "make", "all"
    bin.install "src/upx.out" => "upx"
    man1.install "doc/upx.1"
  end

  test do
    cp "#{bin}/upx", "."
    chmod 0755, "./upx"

    system "#{bin}/upx", "-1", "./upx"
    system "./upx", "-V" # make sure the binary we compressed works
    system "#{bin}/upx", "-d", "./upx"
  end
end
