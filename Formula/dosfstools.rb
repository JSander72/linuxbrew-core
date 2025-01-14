class Dosfstools < Formula
  desc "Tools to create, check and label file systems of the FAT family"
  homepage "https://github.com/dosfstools"
  url "https://github.com/dosfstools/dosfstools/releases/download/v4.2/dosfstools-4.2.tar.gz"
  sha256 "64926eebf90092dca21b14259a5301b7b98e7b1943e8a201c7d726084809b527"
  license "GPL-3.0-or-later"
  head "https://github.com/dosfstools/dosfstools.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3d8437b8921385c7675d2502c0c7b746f060e6b1656923e061173d568927f34d"
    sha256 cellar: :any_skip_relocation, big_sur:       "c4f450bef47449fa57d911e1c3610cd65bf8d7fd661e3efc8a0a44c7d45510f5"
    sha256 cellar: :any_skip_relocation, catalina:      "df9afee3d6ec3da028a6fdd487b98800099f8aa248261c35ed2821e984b91a70"
    sha256 cellar: :any_skip_relocation, mojave:        "4d910d3f83352692379e5ead97f3c52ab845cc187a1d791f655ed02ef7b7b9e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ae69f175b1e6d1fde2345f3f0cc42a78831e38f7847cce79147072d263e8e3c1" # linuxbrew-core
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "pkg-config" => :build

  # remove in next release
  # https://github.com/dosfstools/dosfstools/pull/158
  patch do
    url "https://github.com/dosfstools/dosfstools/commit/8a917ed2afb2dd2a165a93812b6f52b9060eec5f.patch?full_index=1"
    sha256 "73019e3f7852158bfe47a0105eb605b4df4a10ca50befc02adf50aed11bd4445"
  end

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--prefix=#{prefix}",
                          "--without-udev",
                          "--enable-compat-symlinks"
    system "make", "install"
  end

  test do
    system "dd", "if=/dev/zero", "of=test.bin", "bs=512", "count=1024"
    system "#{sbin}/mkfs.fat", "test.bin", "-n", "HOMEBREW", "-v"
    system "#{sbin}/fatlabel", "test.bin"
    system "#{sbin}/fsck.fat", "-v", "test.bin"
  end
end
