class Metis < Formula
  desc "Programs that partition graphs and order matrices"
  homepage "http://glaros.dtc.umn.edu/gkhome/views/metis"
  url "http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz"
  sha256 "76faebe03f6c963127dbb73c13eab58c9a3faeae48779f049066a21c087c5db2"

  livecheck do
    url "http://glaros.dtc.umn.edu/gkhome/metis/metis/download"
    regex(%r{href=.*?/metis[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "ea93856908a2c1c60023dd2f849339d479b20ab4ae6d51623f9496f64993ca20"
    sha256 cellar: :any, big_sur:       "bca0197271b673ba235c37334494b47250c9732e9a0164d8ee79948fc3cd4308"
    sha256 cellar: :any, catalina:      "b410b124973bf31beb58806d4050b8dda1fb3dca679fc3443514025200fd4a37"
    sha256 cellar: :any, mojave:        "f3cdcf0cc5af4ddd27a4550d4a73cffcb34058fe34604b09d453610460d24465"
    sha256 cellar: :any, high_sierra:   "88b6965d941a87044150238387971c4bb94ed2ffca327affccaf311d666a2b4b"
    sha256 cellar: :any, sierra:        "9c8deed80ece8c24e7ebccbce8410557b27afe711d3f59fccb7d781254d0cc34"
    sha256 cellar: :any, el_capitan:    "54f75262475744bc6ad3ba66ac801e03c18bbac00a9bcf0ca9d05853f2022498"
    sha256 cellar: :any, yosemite:      "b33c2fc2c8a1cdb9f48faf41201bdc6384090b8dbd6ed3eecd05264eb6431c0b"
    sha256 cellar: :any, x86_64_linux:  "5bae428970f681f9bea501461d755d60127ab380bc0572b35156c4733021df22" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "make", "config", "prefix=#{prefix}", "shared=1"
    system "make", "install"

    pkgshare.install "graphs"
  end

  test do
    ["4elt", "copter2", "mdual"].each do |g|
      cp pkgshare/"graphs/#{g}.graph", testpath
      system "#{bin}/graphchk", "#{g}.graph"
      system "#{bin}/gpmetis", "#{g}.graph", "2"
      system "#{bin}/ndmetis", "#{g}.graph"
    end
    cp [pkgshare/"graphs/test.mgraph", pkgshare/"graphs/metis.mesh"], testpath
    system "#{bin}/gpmetis", "test.mgraph", "2"
    system "#{bin}/mpmetis", "metis.mesh", "2"
  end
end
