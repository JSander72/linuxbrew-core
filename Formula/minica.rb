class Minica < Formula
  desc "Small, simple certificate authority"
  homepage "https://github.com/jsha/minica"
  url "https://github.com/jsha/minica/archive/v1.0.2.tar.gz"
  sha256 "c5b7e6c890ad472eb39f7e44d777da1b623930fd099b414213ced14bb599c6ec"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5e6f68245edcd602ca5fe8ab2b98c5aef62e826bc1e5f6660c710d886c308bc8"
    sha256 cellar: :any_skip_relocation, big_sur:       "a0ae49ee8f0a7dd9804c19e899efad38c95632c572cf440f247fbf8c902072c2"
    sha256 cellar: :any_skip_relocation, catalina:      "6ed3047835593e51bddc2f1150ca3db84f736c4714442140ed693e23561053ee"
    sha256 cellar: :any_skip_relocation, mojave:        "3665f724fc7ca7da303894232bceda5f53b3aa75d6fe010f77635f75062212d7"
    sha256 cellar: :any_skip_relocation, high_sierra:   "898ae6355e98099a2692f397b58c497dbed656a7859ed8bfb9e045fc4af56a0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1317f1563467da37b9041d490b49eed7b509a01433560fcd3c82101619287d47" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"minica"
  end

  test do
    system "#{bin}/minica", "--domains", "foo.com"
    assert_predicate testpath/"minica.pem", :exist?
  end
end
