class Picocom < Formula
  desc "Minimal dumb-terminal emulation program"
  homepage "https://github.com/npat-efault/picocom"
  url "https://github.com/npat-efault/picocom/archive/3.1.tar.gz"
  sha256 "e6761ca932ffc6d09bd6b11ff018bdaf70b287ce518b3282d29e0270e88420bb"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "040c02cc9b9add2716825840b6f993681995c0596da95c15d7aa1f9c993bdc06"
    sha256 cellar: :any_skip_relocation, big_sur:       "dceb5709b27aaf4aeba18ef67cafba36bc03c07a1c0bac079e96c2632526764b"
    sha256 cellar: :any_skip_relocation, catalina:      "87d54fb026172496e7d2c370e9935e53ece5069351ba3bffc8062b4935ecedc3"
    sha256 cellar: :any_skip_relocation, mojave:        "e087cd6b60814a9b0638d6bdcc3a79e154b40f5013a0247878c1f1ab35c8d077"
    sha256 cellar: :any_skip_relocation, high_sierra:   "7fec5e767653710fa87d0be9d97735550af70aeb32fdcba1c7c0159e9078ee1a"
    sha256 cellar: :any_skip_relocation, sierra:        "fb1bd439cb84f2667feee5e5c125ec9a51698e7d153c56decf95502848edc621"
    sha256 cellar: :any_skip_relocation, el_capitan:    "ec353723ddf1f785bd75bb3a0e9bd5e92adacbe5b4a86ed5dabe53d20b1a362c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10875c8bcb8fb836a0ffae01574a84576558f7717d55c80c1b513fb60c5d4c49" # linuxbrew-core
  end

  def install
    system "make"
    bin.install "picocom"
    man1.install "picocom.1"
  end

  test do
    system "#{bin}/picocom", "--help"
  end
end
