class Ssss < Formula
  desc "Shamir's secret sharing scheme implementation"
  homepage "http://point-at-infinity.org/ssss/"
  url "http://point-at-infinity.org/ssss/ssss-0.5.tar.gz"
  sha256 "5d165555105606b8b08383e697fc48cf849f51d775f1d9a74817f5709db0f995"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?ssss[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "c1656cbcd114f1e8269d54fa5b525ceababe178d0fddec508fdb568d747035f0"
    sha256 cellar: :any, big_sur:       "5ff50aef8004346c9cf21eb9aecae18ce2b7d4032c7460284b6c1903dc244d6f"
    sha256 cellar: :any, catalina:      "ba1cd924e9aa97d91ff125c082ff9d1b2eb7ce3bea642edc1ae9c4f94340d19d"
    sha256 cellar: :any, mojave:        "96db005b3a278b26b7756c3dde1f94975cd09d901191029cf35649dfc1ac1178"
    sha256 cellar: :any, high_sierra:   "af51b1deda77dc64304532dbe4131a02520a8e619f5aea178eeef9d30f87f2c9"
    sha256 cellar: :any, sierra:        "d6c84cc81a0e079f55b32bf3bc35be3a70016226f5cb0e6d1862c9dca22aaa56"
    sha256 cellar: :any, el_capitan:    "ffc9b4c320b50f3d093000f9cde8fff3e4f2869ff4111a7da25b0cf17a2bc065"
    sha256 cellar: :any, yosemite:      "8242a9583ca549f506c107ee1df51c19b04790a8f64605d67ffcd62de34c21ea"
  end

  depends_on "gmp"
  depends_on "xmltoman"

  def install
    inreplace "Makefile" do |s|
      # Compile with -DNOMLOCK to avoid warning on every run on macOS.
      s.gsub! "-W ", "-W -DNOMLOCK $(CFLAGS) $(LDFLAGS)"
    end

    system "make"
    man1.install "ssss.1"
    bin.install %w[ssss-combine ssss-split]
  end
end
