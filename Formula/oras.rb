class Oras < Formula
  desc "OCI Registry As Storage"
  homepage "https://github.com/oras-project/oras"
  url "https://github.com/oras-project/oras/archive/v0.12.0.tar.gz"
  sha256 "5e19d61683a57b414efd75bd1b0290c941b8faace5fcc9d488f5e4aa674bf03e"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0b3b53df6013d9b3ad1ab832a8d0daad2ae4fbb017adf387b7f6d13e5e2d76bd"
    sha256 cellar: :any_skip_relocation, big_sur:       "18d86fcc6965357bb00cc945ef6ee888f874eb487bb341a1389cf8f9cac626d1"
    sha256 cellar: :any_skip_relocation, catalina:      "d08f9849ddb604f0fd61574afd8f2dad30fc38022b14b547c2abd50bb6ef97d9"
    sha256 cellar: :any_skip_relocation, mojave:        "ef76f4634fe95c6c000f90c3ddb323b8edf694f60e5e6eed4e416bef3b874f15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cf97c4634144b90194636b391db6d03f37bab6c58d58c48f20cc920063165c60" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/oras-project/oras/internal/version.Version=#{version}
      -X github.com/oras-project/oras/internal/version.BuildMetadata=Homebrew
    ]
    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "./cmd/oras"
  end

  test do
    assert_match "#{version}+Homebrew", shell_output("#{bin}/oras version")

    port = free_port
    contents = <<~EOS
      {
        "key": "value",
        "this is": "a test"
      }
    EOS
    (testpath/"test.json").write(contents)
    hash = Digest::SHA256.hexdigest(contents)

    # Although it might not make much sense passing the JSON as both manifest and payload,
    # it helps make the test consistent as the error can randomly switch between either hash
    output = shell_output("oras push localhost:#{port}/test-artifact:v1 " \
                          "--manifest-config test.json:application/vnd.homebrew.test.config.v1+json " \
                          "./test.json 2>&1", 1)
    assert_match %r{
       ^Error:\ failed\ to\ do\ request(.*)
       http://localhost:#{port}/v2/test-artifact/blobs/sha256:#{hash}
    }x, output
  end
end
