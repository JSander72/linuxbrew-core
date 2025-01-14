class Darkhttpd < Formula
  desc "Small static webserver without CGI"
  homepage "https://unix4lyfe.org/darkhttpd/"
  url "https://github.com/emikulic/darkhttpd/archive/v1.13.tar.gz"
  sha256 "1d88c395ac79ca9365aa5af71afe4ad136a4ed45099ca398168d4a2014dc0fc2"
  license "ISC"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "36ae262543c3c5a76c282267e400ed1566cf31d1955f9a2d2298e2cb14a42cc8"
    sha256 cellar: :any_skip_relocation, big_sur:       "1643b2894325e4ed51b6007c1f1c6a935cc0780f48f3d953620d7b0ab50d6dbc"
    sha256 cellar: :any_skip_relocation, catalina:      "161992a2da584f5704fc6923d26fe6675a2ac23b3a66d9c1bba154b2a5888833"
    sha256 cellar: :any_skip_relocation, mojave:        "fdc947505f7ee3885b23431afe3603cb6e75f7edeea9784dab45975b30956086"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2cdf1c1b081997f17209f8c98e4250356eb9c1da40cf167b4fba49df201c5070" # linuxbrew-core
  end

  def install
    system "make"
    bin.install "darkhttpd"
  end

  test do
    system "#{bin}/darkhttpd", "--help"
  end
end
