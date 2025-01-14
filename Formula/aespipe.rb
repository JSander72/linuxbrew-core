class Aespipe < Formula
  desc "AES encryption or decryption for pipes"
  homepage "https://loop-aes.sourceforge.io/"
  url "https://loop-aes.sourceforge.io/aespipe/aespipe-v2.4f.tar.bz2"
  sha256 "b135e1659f58dc9be5e3c88923cd03d2a936096ab8cd7f2b3af4cb7a844cef96"

  livecheck do
    url "http://loop-aes.sourceforge.net/aespipe/"
    regex(/href=.*?aespipe[._-]v?(\d+(?:\.\d+)+[a-z])\.t/i)
    strategy :page_match
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "204ddb0b9c6fde98f4bdec7c3c93aa2ad95cde565dd22538f2c61a55875a398e"
    sha256 cellar: :any_skip_relocation, big_sur:       "b94579255152f8761049784697e757d2399f075bb77b7c194741311aad2943c3"
    sha256 cellar: :any_skip_relocation, catalina:      "c96c3f1ba5bcd7672630d7c9d693cb5d9333e3473ecdca6771290a68ac54db2e"
    sha256 cellar: :any_skip_relocation, mojave:        "f52e6c3afc951ca588522d8073b62300113a30cb6d3927a25de643cc10622d74"
    sha256 cellar: :any_skip_relocation, high_sierra:   "00d7cb8240e8e1beb4b8cf701bf38961531df8a9f2d497c4ff5a95747ac3dbae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1f386c2d3388f3feb5a0a5e33f1e67d7465c5d5f9a3287a2c89cb9a6788d6f0" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"secret").write "thisismysecrethomebrewdonttellitplease"
    msg = "Hello this is Homebrew"
    encrypted = pipe_output("#{bin}/aespipe -P secret", msg)
    decrypted = pipe_output("#{bin}/aespipe -P secret -d", encrypted)
    assert_equal msg, decrypted.gsub(/\x0+$/, "")
  end
end
