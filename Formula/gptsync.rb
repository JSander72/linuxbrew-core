class Gptsync < Formula
  desc "GPT and MBR partition tables synchronization tool"
  homepage "https://refit.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/refit/rEFIt/0.14/refit-src-0.14.tar.gz"
  sha256 "c4b0803683c9f8a1de0b9f65d2b5a25a69100dcc608d58dca1611a8134cde081"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ce578e36d0f50ee223a8578434563aa237ee4c98d951d8c818c21571258193a5"
    sha256 cellar: :any_skip_relocation, big_sur:       "7b7bf7603d6040dbb5b1982641e3a8f7bf70a7c96c5a8c476b57a344609b9705"
    sha256 cellar: :any_skip_relocation, catalina:      "e6761d20c0090477f2914576cbb97654774a5de9cae4b3846187120961450ed0"
    sha256 cellar: :any_skip_relocation, mojave:        "76d760477b55a2ac3ebe3d2fb472e70ccd84a2fa8cb265bae829669e639897f3"
    sha256 cellar: :any_skip_relocation, high_sierra:   "8d21fa7f491b5cfe7a2c809a99d753ff4511c5354c4761751ab9c5abebd585c6"
    sha256 cellar: :any_skip_relocation, sierra:        "e822ef6c99aeaf6eee5812cd83ede2bc9a045dd556105150293bcf486898a59d"
    sha256 cellar: :any_skip_relocation, el_capitan:    "d355de7bea36e310d22ed1109a34574ab93859bfe9e44b9493ebe75cfe429c33"
    sha256 cellar: :any_skip_relocation, yosemite:      "34756250a7bbd8470dd98401c86c65d9886cfac802adb2371bf0a23fa9351f7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d7a463576f3fc3f18278aedf5aeae3358a1924f439899d32279ed8bdb0e6e31" # linuxbrew-core
  end

  def install
    cd "gptsync" do
      system "make", "-f", "Makefile.unix", "CC=#{ENV.cc}"
      sbin.install "gptsync", "showpart"
      man8.install "gptsync.8"
    end
  end
end
