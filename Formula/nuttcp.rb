class Nuttcp < Formula
  desc "Network performance measurement tool"
  homepage "https://www.nuttcp.net/nuttcp/"
  url "https://www.nuttcp.net/nuttcp/nuttcp-8.2.2.tar.bz2"
  sha256 "7ead7a89e7aaa059d20e34042c58a198c2981cad729550d1388ddfc9036d3983"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?nuttcp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c284b20a30f158f7321ca918bc27ffac8f5e644e85acba6231477aa9c4a9f06e"
    sha256 cellar: :any_skip_relocation, big_sur:       "9001ef97c90c4097f1ebabed20e63305f82a5f04d7ffc0f0d788c249c49d236d"
    sha256 cellar: :any_skip_relocation, catalina:      "0f5e7a2b61f91360023ef643c0a77fa711855b34006ff07867f1283051aded5c"
    sha256 cellar: :any_skip_relocation, mojave:        "de0d1395983d9980dfff73de8282b76bf70c987fb36c68ff5e341f245507100a"
    sha256 cellar: :any_skip_relocation, high_sierra:   "8d9ea3c88d5347b34cc4b3385b6898f942b8e4ff5a4f4a26897e4b66297e2692"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dbe782d8e379330f336221d4a723784201d87fe304b7a5718996800c3519b292" # linuxbrew-core
  end

  def install
    system "make", "APP=nuttcp",
           "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}"
    bin.install "nuttcp"
    man8.install "nuttcp.cat" => "nuttcp.8"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/nuttcp -V")
  end
end
