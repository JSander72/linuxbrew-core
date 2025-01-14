class Mailcheck < Formula
  desc "Check multiple mailboxes/maildirs for mail"
  homepage "https://mailcheck.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/mailcheck/mailcheck/1.91.2/mailcheck_1.91.2.tar.gz"
  sha256 "6ca6da5c9f8cc2361d4b64226c7d9486ff0962602c321fc85b724babbbfa0a5c"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:      "59d3c8716efff8670b81cec68c47b0663ffa079938ee6aae55078770564fa481"
    sha256 cellar: :any_skip_relocation, catalina:     "66fa586c21ec0cd9a842fcb99e8bbf822681c8858b864b14aa7d57ea89c47a99"
    sha256 cellar: :any_skip_relocation, mojave:       "7ea23945f9750c34d71ff05c5f41c0f5352e3eecaf1c7cf485d4f51096b9dd4e"
    sha256 cellar: :any_skip_relocation, high_sierra:  "c630704fee3dea86402e7486295a13601077bd991e45f23d3ac841c95a9c4474"
    sha256 cellar: :any_skip_relocation, sierra:       "8d33e3b08eef4dfaa7fa3d2c4e5f4a697cd2e5eb950c963f1f0845c0651da5ea"
    sha256 cellar: :any_skip_relocation, el_capitan:   "b7c134dc23431dfaa3f402b859b7154cab5e176711363bd884dc82ce896d7c7a"
    sha256 cellar: :any_skip_relocation, yosemite:     "242b05a6e9b8ccc1ac70e22cbf89bc33a885e726d32509fad6b34a3bee123945"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bf25c7173600f92fb766d88b1a85e8662ced6c32c58410fc08fa519351fa2375" # linuxbrew-core
  end

  def install
    system "make", "mailcheck"
    bin.install "mailcheck"
    man1.install "mailcheck.1"
    etc.install "mailcheckrc"
  end
end
