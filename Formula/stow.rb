class Stow < Formula
  desc "Organize software neatly under a single directory tree (e.g. /usr/local)"
  homepage "https://www.gnu.org/software/stow/"
  url "https://ftp.gnu.org/gnu/stow/stow-2.3.1.tar.gz"
  mirror "https://ftpmirror.gnu.org/stow/stow-2.3.1.tar.gz"
  sha256 "09d5d99671b78537fd9b2c0b39a5e9761a7a0e979f6fdb7eabfa58ee45f03d4b"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f6dc9f73ac8ef55caa0f8204c893bf41dcdffbae22b39d95a85eee5c99507b55"
    sha256 cellar: :any_skip_relocation, big_sur:       "e2a4d5cae000bcb2a5464f618b0c1fb174f4c90f66793411ff3c3bdda0438083"
    sha256 cellar: :any_skip_relocation, catalina:      "c99a90dc5e3db8ebcb017df044723fb4e6cce7fb94aa24cf46c8d2c0665bf9a0"
    sha256 cellar: :any_skip_relocation, mojave:        "409987564f7779d6a1db75f64e54c4713ecd9b9e006abac931f8e8d645bdac92"
    sha256 cellar: :any_skip_relocation, high_sierra:   "409987564f7779d6a1db75f64e54c4713ecd9b9e006abac931f8e8d645bdac92"
    sha256 cellar: :any_skip_relocation, sierra:        "cbc7a61940a343aff46fdb6190dc26a359d26c9c468c05b1dbde2484a066ceb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9c9d729eedfc866f0303dddf4ad36e94cf0e5711846724bebdda4b0e1acbf61" # linuxbrew-core
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test").mkpath
    system "#{bin}/stow", "-nvS", "test"
  end
end
