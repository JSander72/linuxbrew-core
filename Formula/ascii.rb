class Ascii < Formula
  desc "List ASCII idiomatic names and octal/decimal code-point forms"
  homepage "http://www.catb.org/~esr/ascii/"
  url "http://www.catb.org/~esr/ascii/ascii-3.18.tar.gz"
  sha256 "728422d5f4da61a37a17b4364d06708e543297de0a5f70305243236d80df072d"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/ascii[._-]v?(\d+(?:\.\d+)+)/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "961354b48b260c83374340b6f50bb440977edc81ffa6cb11293bd6265f94dd3e"
    sha256 cellar: :any_skip_relocation, big_sur:       "ae1f4bca216200b2633f93da6d99c991f15755a130bd1cbc680377c251555d32"
    sha256 cellar: :any_skip_relocation, catalina:      "2c106e2d3ce3534f09a5ce147f6fc0778e884d06f15e7c272ee99ccabaf947bd"
    sha256 cellar: :any_skip_relocation, mojave:        "d5f4c8fe4ad1467c1708e49268a42f0d201f8c18ed912cf3de330bdf1f219cc1"
    sha256 cellar: :any_skip_relocation, high_sierra:   "858e5bd8f55367349f936f47346a7d4dc2afed7c8f3d9fca16c42071f537f644"
    sha256 cellar: :any_skip_relocation, sierra:        "52fb2a78a1409f4f6db0b59589f773c4427c87a84a7fee1809e5f0a4d50e4d65"
    sha256 cellar: :any_skip_relocation, el_capitan:    "bbb5f365f96e42dfaa8af31f21daa8809b0a628451599fab7bc7509ceeb0d14f"
    sha256 cellar: :any_skip_relocation, yosemite:      "ab520ebbe64a946a0ac0466537a0e207e49cd85979e41582ab542dcaef9db3ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88fa5c873c23b41bab19a85e5feb572ae1a5369885b53a158ba1e0cce52980ef" # linuxbrew-core
  end

  head do
    url "https://gitlab.com/esr/ascii.git"
    depends_on "xmlto" => :build
  end

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog" if build.head?
    bin.mkpath
    man1.mkpath
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match "Official name: Line Feed", shell_output(bin/"ascii 0x0a")
  end
end
