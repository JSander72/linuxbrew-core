class Cidrmerge < Formula
  desc "CIDR merging with network exclusion"
  homepage "https://cidrmerge.sourceforge.io"
  url "https://downloads.sourceforge.net/project/cidrmerge/cidrmerge/cidrmerge-1.5.3/cidrmerge-1.5.3.tar.gz"
  sha256 "21b36fc8004d4fc4edae71dfaf1209d3b7c8f8f282d1a582771c43522d84f088"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "49083b84e43debb1921bf1e3788dd5614bcbac3d70b68d099734421fa94f7fd5"
    sha256 cellar: :any_skip_relocation, big_sur:       "5f11e096d4f5b0af52ec6822f2fba79bd053c083b114f41fcc9ca40112daf5db"
    sha256 cellar: :any_skip_relocation, catalina:      "5828da34c41143336cced7cc8051efd63d525c1a1a4788c6c1235d4bc75cf3df"
    sha256 cellar: :any_skip_relocation, mojave:        "aa994dfc09a72377c001b0f94a0d8674034fe626e2d1a8bba0d6d514e849564b"
    sha256 cellar: :any_skip_relocation, high_sierra:   "61d2b647e77f706f53ef22dcb1ad362d39bed01f2bed08270bc6110824233146"
    sha256 cellar: :any_skip_relocation, sierra:        "8f2cf233141b0ea465c05d3487718176bb40023a05ecf7c275fdae9c36a5eef1"
    sha256 cellar: :any_skip_relocation, el_capitan:    "7e607252679cd1648e6c9f48ebbeaa2379ce089ad87815bd6636e65dcedebc7b"
    sha256 cellar: :any_skip_relocation, yosemite:      "20c6f57fc6081c8d27d2e68b81e3d4c5cd68e7c799dc30e076f45ee71b42e69d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d9f0abe1ec4904e40318954285c522fa2bfce4117c3ae70386b7f86cd01a0d2" # linuxbrew-core
  end

  def install
    system "make"
    bin.install "cidrmerge"
  end

  test do
    input = <<~EOS
      10.1.1.0/24
      10.1.1.1/32
      192.1.4.5/32
      192.1.4.4/32
    EOS
    assert_equal "10.1.1.0/24\n192.1.4.4/31\n", pipe_output("#{bin}/cidrmerge", input)
  end
end
