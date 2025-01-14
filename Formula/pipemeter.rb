class Pipemeter < Formula
  desc "Shows speed of data moving from input to output"
  homepage "https://launchpad.net/pipemeter"
  url "https://launchpad.net/pipemeter/trunk/1.1.5/+download/pipemeter-1.1.5.tar.gz"
  sha256 "e470ac5f3e71b5eee1a925d7174a6fa8f0753f2107e067fbca3f383fab2e87d8"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1ca7da50232374280744805d8497a42c4e8795d4592a1e6ec35fb3e51812cea9"
    sha256 cellar: :any_skip_relocation, big_sur:       "ef9f94223b9b5d583ca7f3714e85fbdc59721be6bdc31f46bda43cecb4a4c0b5"
    sha256 cellar: :any_skip_relocation, catalina:      "faf2fcb90aebb9e26bfd1f9dcfd32bb43fd4247a87a466640dcd74824806da00"
    sha256 cellar: :any_skip_relocation, mojave:        "73de834fc4df5c79baf9cffc35fbe14df34e35e8414c1d3648326de9a5ced34c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80837101e6c422153ebe6525c69b2dedfdd0134c1414866a98266447930511ce" # linuxbrew-core
  end

  def install
    system "./configure", "--disable-debug",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"

    # Fix GNU `install -D` syntax issue
    inreplace "Makefile", "install -Dp -t $(DESTDIR)$(PREFIX)/bin pipemeter",
                          "install -p pipemeter $(PREFIX)/bin"
    inreplace "Makefile", "install -Dp -t $(DESTDIR)$(PREFIX)/man/man1 pipemeter.1",
                          "install -p pipemeter.1 $(PREFIX)/share/man/man1"

    bin.mkpath
    man1.mkpath
    system "make", "install"
  end

  test do
    assert_match "3.00B", pipe_output("#{bin}/pipemeter -r 2>&1 >/dev/null", "foo", 0)
  end
end
