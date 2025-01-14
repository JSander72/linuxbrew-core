class Tkdiff < Formula
  desc "Graphical side by side diff utility"
  homepage "https://tkdiff.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/tkdiff/tkdiff/5.2.1/tkdiff-5-2-1.zip"
  version "5.2.1"
  sha256 "942bf2431b409ecfdcd1789b9911888f69908e63e02c923bb5b04b2aeb14633d"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(%r{url=.*?/tkdiff/v?(\d+(?:\.\d+)+)/[^"]+?\.zip}i)
  end

  def install
    bin.install "tkdiff"
  end

  test do
    system "#{bin}/tkdiff", "--help"
  end
end
