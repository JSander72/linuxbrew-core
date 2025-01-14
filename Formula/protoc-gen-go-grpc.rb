class ProtocGenGoGrpc < Formula
  desc "Protoc plugin that generates code for gRPC-Go clients"
  homepage "https://github.com/grpc/grpc-go"
  url "https://github.com/grpc/grpc-go/archive/cmd/protoc-gen-go-grpc/v1.1.0.tar.gz"
  sha256 "9aa1f1f82b45a409c25eb7c06c6b4d2a41eb3c9466ebd808fe6d3dc2fb9165b3"
  license "Apache-2.0"
  revision 2

  livecheck do
    url :stable
    regex(%r{cmd/protoc-gen-go-grpc/v?(\d+(?:\.\d+)+)}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ad604447808fa88d386c5864726985220ec03a5cb7dd17f2c8deb1de3b1ba86e"
    sha256 cellar: :any_skip_relocation, big_sur:       "c288d0096bfeff80418f468a0a1c92aaa43dd31f62a3e2f37f14ad5577ebbcc8"
    sha256 cellar: :any_skip_relocation, catalina:      "c288d0096bfeff80418f468a0a1c92aaa43dd31f62a3e2f37f14ad5577ebbcc8"
    sha256 cellar: :any_skip_relocation, mojave:        "c288d0096bfeff80418f468a0a1c92aaa43dd31f62a3e2f37f14ad5577ebbcc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2785faee66967efbf25498b6af1fce6d105654e6d21161ddcb71c97628eb653f" # linuxbrew-core
  end

  depends_on "go" => :build
  depends_on "protobuf"

  def install
    cd "cmd/protoc-gen-go-grpc" do
      system "go", "build", *std_go_args
    end
  end

  test do
    (testpath/"service.proto").write <<~EOS
      syntax = "proto3";

      option go_package = ".;proto";

      service Greeter {
        rpc Hello(HelloRequest) returns (HelloResponse);
      }

      message HelloRequest {}
      message HelloResponse {}
    EOS

    system "protoc", "--plugin=#{bin}/protoc-gen-go-grpc", "--go-grpc_out=.", "service.proto"

    assert_predicate testpath/"service_grpc.pb.go", :exist?
  end
end
