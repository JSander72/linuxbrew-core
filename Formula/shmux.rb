class Shmux < Formula
  desc "Execute the same command on many hosts in parallel"
  homepage "https://github.com/shmux/shmux"
  url "https://github.com/shmux/shmux/archive/v1.0.3.tar.gz"
  sha256 "c9f8863e2550e23e633cf5fc7a9c4c52d287059f424ef78aba6ecd98390fb9ab"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "341ede51de6b3dbb5b0f6acc554a2dfc7c9543cb3800e06a992f8b40a58b3657"
    sha256 cellar: :any_skip_relocation, big_sur:       "6f8ae1c07788268ee86531da66940e7648dce1dc63a6ed118a2bacc0899beac9"
    sha256 cellar: :any_skip_relocation, catalina:      "6781e9876911d4d44080b069dd3295c86520699ae24b3385980d51a53bc4d2f3"
    sha256 cellar: :any_skip_relocation, mojave:        "e433bd14622d3f77a35042649d0d73e888b164ab4f04431864fb68c9ec64b62c"
    sha256 cellar: :any_skip_relocation, high_sierra:   "bc38ad3a6feddd116edd9d3ab00ac18bc6663d08b9d111414975bdd1543d1b79"
    sha256 cellar: :any_skip_relocation, sierra:        "13f8831248e646784dd3cefd82707c45966ea05528e0c836156dea98b9c8c870"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9f5655875e42cc02cdc82f49a3aa29d2b9b3af7f5eff7f8c9dd8ffbe14262ed" # linuxbrew-core
  end

  uses_from_macos "ncurses"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/shmux", "-h"
  end
end
