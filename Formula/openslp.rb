class Openslp < Formula
  desc "Implementation of Service Location Protocol"
  homepage "http://www.openslp.org"
  url "https://downloads.sourceforge.net/project/openslp/2.0.0/2.0.0%20Release/openslp-2.0.0.tar.gz"
  sha256 "924337a2a8e5be043ebaea2a78365c7427ac6e9cee24610a0780808b2ba7579b"

  bottle do
    sha256 big_sur:      "3cc88f489dfe6e4e9566608ace194fb8e09a8cb28f80947d7454f03494d76341"
    sha256 catalina:     "fee6eb82ad60bf1446278498ff8860584dcd2192a7505f3c57eec2bab55f337f"
    sha256 mojave:       "948182086a86baa001d9b8864715c91d5d9b9ec76ba7c072667dc0d58e983d12"
    sha256 high_sierra:  "3a933a2c697a2b7a00d9b1f9cc3a58664c43c18f7b4ff3d99afa7bc11d721da5"
    sha256 sierra:       "fdd847dba24e5a96c30ccef98f0d035f39abc88617d779df627c132be5b648ae"
    sha256 el_capitan:   "1c19d8355ddda63b9259101a0b7b56ea0fd9fb8f343e2df19f7248542fbf38e5"
    sha256 yosemite:     "95e41f7f42e80ab3234b460d90196389a0d275877195fe188ffc6249c0b762ce"
    sha256 x86_64_linux: "4bc594636cf22b11cd255c2db2c046ec4f3af30f3ac5b1e90e665f0c47743f78" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
