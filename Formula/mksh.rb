class Mksh < Formula
  desc "MirBSD Korn Shell"
  homepage "https://www.mirbsd.org/mksh.htm"
  url "https://www.mirbsd.org/MirOS/dist/mir/mksh/mksh-R59c.tgz"
  mirror "https://pub.allbsd.org/MirOS/dist/mir/mksh/mksh-R59c.tgz"
  version "59c"
  sha256 "77ae1665a337f1c48c61d6b961db3e52119b38e58884d1c89684af31f87bc506"

  livecheck do
    url "https://www.mirbsd.org/MirOS/dist/mir/mksh/"
    regex(/href=.*?mksh-R?(\d+[a-z]?)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4e5b153d2643f455c5be25fa8f751eed863393b454abc3df8bb9b145799152e0"
    sha256 cellar: :any_skip_relocation, big_sur:       "879b0a3185d7cb75235a3204cba1b66e7353b77458b63deef3c7635e75f52ba4"
    sha256 cellar: :any_skip_relocation, catalina:      "ab6ffddb634219464c5993a9109a051fa728f217b7c89daa95d5b85748127bf5"
    sha256 cellar: :any_skip_relocation, mojave:        "354bd63fa78b08ba32eec9478a1ac6ee48276e529c3d37321808be3c5b3b3050"
    sha256 cellar: :any_skip_relocation, high_sierra:   "82f9d2a32196df99bc9b2a21e1a062bfc99c263a9a0ee522831d12dce3fd5b5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e1e9c9fc3f0abd588b63870a15d22102170161f67b3d7d02e6d2ac65918df663" # linuxbrew-core
  end

  def install
    system "sh", "./Build.sh", "-r"
    bin.install "mksh"
    man1.install "mksh.1"
  end

  test do
    assert_equal "honk",
      shell_output("#{bin}/mksh -c 'echo honk'").chomp
  end
end
