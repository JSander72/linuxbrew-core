class JsonnetBundler < Formula
  desc "Package manager for Jsonnet"
  homepage "https://github.com/jsonnet-bundler/jsonnet-bundler"
  url "https://github.com/jsonnet-bundler/jsonnet-bundler.git",
      tag:      "v0.4.0",
      revision: "447344d5a038562d320a3f0dca052611ade29280"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a9b6b525e1f410fe49f0b2b5589f48662dcde94716371f8cf77b61ba69589d49"
    sha256 cellar: :any_skip_relocation, big_sur:       "6f52c9470db16a9f06797f01b5af31e55336ad809bb28ed3eacb985a3aa08067"
    sha256 cellar: :any_skip_relocation, catalina:      "1d90eef17450bddbe12e3bbc65d55d2b324a34f2cb36a028b32060e416e262c1"
    sha256 cellar: :any_skip_relocation, mojave:        "a42bfdfd2d149e8667ff0849de992e91160e78aaed6f72f2624f9a191c83fe75"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e058cee6482accf6cc38bb4c404148464e4e071cecdb7191e1fbc6315e53f851"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "badcbd54eb6dbc1a03d1cccdf08e80cf9e742e18dd91d8395e3b9e9579a57113" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "make", "static"
    bin.install "_output/jb"
  end

  test do
    assert_match "A jsonnet package manager", shell_output("#{bin}/jb 2>&1")

    system bin/"jb", "init"
    assert_predicate testpath/"jsonnetfile.json", :exist?

    system bin/"jb", "install", "https://github.com/grafana/grafonnet-lib"
    assert_predicate testpath/"vendor", :directory?
    assert_predicate testpath/"jsonnetfile.lock.json", :exist?
  end
end
