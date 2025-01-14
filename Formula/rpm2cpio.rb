class Rpm2cpio < Formula
  desc "Tool to convert RPM package to CPIO archive"
  homepage "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/"
  url "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/files/rpm2cpio?revision=408590&view=co"
  version "1.4"
  sha256 "2841bacdadde2a9225ca387c52259d6007762815468f621253ebb537d6636a00"

  livecheck do
    url "https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/Makefile?view=co"
    regex(/^PORTVERSION=\s*?v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "532dfd83bf5efec35d5dad581695ac40e830e9545cf5e2599520e18e385d2d5c"
    sha256 cellar: :any_skip_relocation, big_sur:       "605d2412f20fb282a4b7bf18f67b1ac63382965714f7d6711d13a317e626ae8d"
    sha256 cellar: :any_skip_relocation, catalina:      "8655ba73b79595a55d289c2c969e027f2034c0af88263f9fa8c5cb8a1184a823"
    sha256 cellar: :any_skip_relocation, mojave:        "081902485154a2061d890e6421a55d15bfe5072c05109c79e0ef50f2a11b96e5"
    sha256 cellar: :any_skip_relocation, high_sierra:   "804dccff2726a9ac18a1002cd8adb06aacd07ce1fff93b995c042d4e78775176"
    sha256 cellar: :any_skip_relocation, sierra:        "05f2a6011c554efb2c2196fdf08bfc6f7c6fd6d4e32530399888aabcc73ca339"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bba23286ffed07f93356651aeec6b1a3908b65eee528f24969fd101b9eafc930" # linuxbrew-core
  end

  depends_on "xz"

  def install
    bin.install "rpm2cpio?revision=408590&view=co" => "rpm2cpio"
  end
end
