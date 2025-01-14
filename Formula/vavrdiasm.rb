class Vavrdiasm < Formula
  desc "8-bit Atmel AVR disassembler"
  homepage "https://github.com/vsergeev/vAVRdisasm"
  url "https://github.com/vsergeev/vavrdisasm/archive/v3.1.tar.gz"
  sha256 "4fe5edde40346cb08c280bd6d0399de7a8d2afdf20fb54bf41a8abb126636360"
  license "GPL-3.0-only"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:     "eada6923268ecfe690323de3bafddda5d177cac56ba0f30cf426d015b5b9e538"
    sha256 cellar: :any_skip_relocation, mojave:       "5b0c0f8ae850c12118808020420ed94d9c7b221f1bb64ec81fe5553b089424e4"
    sha256 cellar: :any_skip_relocation, high_sierra:  "14295cb0db6aa3259a2b1e2c8ba020fee253804135aea259695ac00bdd906764"
    sha256 cellar: :any_skip_relocation, sierra:       "c04a9755b9f2e15fa512fdb08d28b95b8cf0304287f3a7930975b4ad75417fcf"
    sha256 cellar: :any_skip_relocation, el_capitan:   "0671b1062a86e8d596a9f404fd843cb37d6d2d1bb28ebb2b8a8f6cbdd763c97c"
    sha256 cellar: :any_skip_relocation, yosemite:     "ce57062586ca9cb91290141376f1da1f5de3c6efb6fe4687585a3e64cc29c014"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0612ed5b89def054568d3ef98a157aaa941d6a82c169950080dfc12bfa2ea84b" # linuxbrew-core
  end

  disable! date: "2020-09-17", because: :unmaintained

  # Patch:
  # - BSD `install(1)' does not have a GNU-compatible `-D' (create intermediate
  #   directories) flag. Switch to using `mkdir -p'.
  # - Make `PREFIX' overridable
  #   https://github.com/vsergeev/vavrdisasm/pull/2
  patch do
    url "https://raw.githubusercontent.com/Homebrew/formula-patches/85fa66a9/vavrdiasm/3.1.patch"
    sha256 "e10f261b26e610e3f522864217b53e7b38d270b5d218a67840a683e1cdc20893"
  end

  def install
    ENV["PREFIX"] = prefix
    system "make"
    system "make", "install"
  end

  test do
    # Code to generate `file.hex':
    ## .device ATmega88
    ##
    ## LDI     R16, 0xfe
    ## SER     R17
    #
    # Compiled with avra:
    ## avra file.S && mv file.S.hex file.hex

    (testpath/"file.hex").write <<~EOS
      :020000020000FC
      :040000000EEF1FEFF1
      :00000001FF
    EOS

    output = `vavrdisasm file.hex`.lines.to_a

    assert output[0].match(/ldi\s+R16,\s0xfe/).length == 1
    assert output[1].match(/ser\s+R17/).length == 1
  end
end
