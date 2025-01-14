class Ucon64 < Formula
  desc "ROM backup tool and emulator's Swiss Army knife program"
  homepage "https://ucon64.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ucon64/ucon64/ucon64-2.2.1/ucon64-2.2.1-src.tar.gz"
  sha256 "e814f427a59866e16fe757bf4af51004ac68be29cabd78944590878f1df73f79"
  license "GPL-2.0-or-later"
  head "https://svn.code.sf.net/p/ucon64/svn/trunk/ucon64"

  livecheck do
    url :stable
    regex(%r{url=.*?/ucon64[._-]v?(\d+(?:\.\d+)+)-src\.t}i)
  end

  bottle do
    sha256 arm64_big_sur: "2f96fb8d33b2dee04afead4f3efcae1d56a34131291446de18300278e10c1df2"
    sha256 big_sur:       "b6b2a89d3da04d4a6ff3ce5fa39f9439ca0c2068d5f66a4a32e9abb4d09be329"
    sha256 catalina:      "a935bde7d18d023d03b38631b9fdb8229bc6b4514bd693cd832515295cc47a7b"
    sha256 mojave:        "3652059ae186bbd01f2fc85586629ac47b2067d0b851d71858d66fb3f4080523"
    sha256 x86_64_linux:  "9c500a88d5ddb548ca2590bf041016204088cabca589f5f404c821620ba0c67d" # linuxbrew-core
  end

  uses_from_macos "unzip" => [:build, :test]
  uses_from_macos "zlib"

  resource "super_bat_puncher_demo" do
    url "http://morphcat.de/superbatpuncher/Super%20Bat%20Puncher%20Demo.zip"
    sha256 "d74cb3ba11a4ef5d0f8d224325958ca1203b0d8bb4a7a79867e412d987f0b846"
  end

  def install
    # ucon64's normal install process installs the discmage library in
    # the user's home folder. We want to store it inside the prefix, so
    # we have to change the default value of ~/.ucon64rc to point to it.
    # .ucon64rc is generated by the binary, so we adjust the default that
    # is set when no .ucon64rc exists.
    inreplace "src/ucon64_misc.c", "PROPERTY_MODE_DIR (\"ucon64\") \"#{shared_library("discmage")}\"",
                                   "\"#{opt_prefix}/libexec/#{shared_library("libdiscmage")}\""

    cd "src" do
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}",
                            "--with-libdiscmage"
      system "make"
      bin.install "ucon64"
      libexec.install "libdiscmage/#{shared_library("discmage")}" => shared_library("libdiscmage")
    end
  end

  def caveats
    <<~EOS
      You can copy/move your DAT file collection to $HOME/.ucon64/dat
      Be sure to check $HOME/.ucon64rc for configuration after running uCON64
      for the first time.
    EOS
  end

  test do
    resource("super_bat_puncher_demo").stage testpath

    assert_match "00000000  4e 45 53 1a  08 00 11 00  00 00 00 00  00 00 00 00",
                 shell_output("#{bin}/ucon64 \"#{testpath}/Super Bat Puncher Demo.nes\"")
  end
end
