class Dnsprobe < Formula
  desc "DNS query and resolution tool"
  homepage "https://github.com/projectdiscovery/dnsprobe"
  url "https://github.com/projectdiscovery/dnsprobe/archive/v1.0.3.tar.gz"
  sha256 "ab57f348177594018cc5b5b5e808710c88e597888c6d504cb10554d60627eae1"
  license "MIT"
  head "https://github.com/projectdiscovery/dnsprobe.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "740bcb0256a1da0e2d89d8a61e82e30eaecef7ac9766ab69b48cc2d5b678858e"
    sha256 cellar: :any_skip_relocation, big_sur:       "4753d6e37449dcf0f823edd0b557526ca8bf9c65da3359d73fef9307e774e6b2"
    sha256 cellar: :any_skip_relocation, catalina:      "e2980ba58e116e7c9029c9255451dd97b65da09a885373afe86c9e860d493650"
    sha256 cellar: :any_skip_relocation, mojave:        "3cf8604d9869f22c722dfa8f0742f12124ba84a160579f0e7964ff7e697631f0"
    sha256 cellar: :any_skip_relocation, high_sierra:   "f6c2b6edb0f8c482488b325400f1d712687a369c8b8fd7fb9e0d0cba1def2273"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37356ce8098f26e610459e942337cd4cac858570995320dbde05004c3d6daeda" # linuxbrew-core
  end

  # repo derecated in favor of `projectdiscovery/dnsx`
  deprecate! date: "2020-11-13", because: :repo_archived

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    (testpath/"domains.txt").write "docs.brew.sh"
    assert_match "docs.brew.sh homebrew.github.io.",
                 shell_output("#{bin}/dnsprobe -l domains.txt -r CNAME")
  end
end
