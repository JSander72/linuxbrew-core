class XercesC < Formula
  desc "Validating XML parser"
  homepage "https://xerces.apache.org/xerces-c/"
  url "https://www.apache.org/dyn/closer.lua?path=xerces/c/3/sources/xerces-c-3.2.3.tar.gz"
  mirror "https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.2.3.tar.gz"
  sha256 "fb96fc49b1fb892d1e64e53a6ada8accf6f0e6d30ce0937956ec68d39bd72c7e"
  revision 1 unless OS.mac?
  license "Apache-2.0"

  bottle do
    rebuild 2
    sha256 cellar: :any,                 arm64_big_sur: "ad9251257543aee28e08fbc5f433a5ad72c0065511c09d19c888bf28b5bbf21f"
    sha256 cellar: :any,                 big_sur:       "6a561a0f4175e7da6790b2beaedf185516a118116402a674a6b936d5c3236575"
    sha256 cellar: :any,                 catalina:      "743af0adcd563f604bf3f057d1144b9e11bc1b5a9e842f82d430301d2b5fc185"
    sha256 cellar: :any,                 mojave:        "cf22a3e57f6e6e279e9eb476bb80c08d18979938f54d19347fd103ccdc7cf78e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cc8041c06f4aea15a1c3c519c71e3663dd53753e781eb8e552ef2127136abe31" # linuxbrew-core
  end

  depends_on "cmake" => :build

  uses_from_macos "curl"

  def install
    ENV.cxx11

    mkdir "build" do
      system "cmake", "..", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
      system "make"
      system "ctest", "-V"
      system "make", "install"
      system "make", "clean"
      system "cmake", "..", "-DBUILD_SHARED_LIBS=OFF", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
      system "make"
      lib.install Dir["src/*.a"]
    end
    # Remove a sample program that conflicts with libmemcached
    # on case-insensitive file systems
    (bin/"MemParse").unlink
  end

  test do
    (testpath/"ducks.xml").write <<~EOS
      <?xml version="1.0" encoding="iso-8859-1"?>

      <ducks>
        <person id="Red.Duck" >
          <name><family>Duck</family> <given>One</given></name>
          <email>duck@foo.com</email>
        </person>
      </ducks>
    EOS

    output = shell_output("#{bin}/SAXCount #{testpath}/ducks.xml")
    assert_match "(6 elems, 1 attrs, 0 spaces, 37 chars)", output
  end
end
