class Mockolo < Formula
  desc "Efficient Mock Generator for Swift"
  homepage "https://github.com/uber/mockolo"
  url "https://github.com/uber/mockolo/archive/1.6.2.tar.gz"
  sha256 "37bd8639349fb292e4244593785be0c63d16fd91b601c10d25a48c0964dd15a2"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9ba2efcb7c4706f4951c4938bd92f8ba9e84f9f8c9b20d00946c720ff1cee665"
    sha256 cellar: :any_skip_relocation, big_sur:       "8c7084c7246c4d70a14cff9af3340a888a3e9560953b3a4d40a532de6da64d51"
  end

  depends_on xcode: ["12.5", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/mockolo"
  end

  test do
    (testpath/"testfile.swift").write <<~EOS
      /// @mockable
      public protocol Foo {
          var num: Int { get set }
          func bar(arg: Float) -> String
      }
    EOS
    system "#{bin}/mockolo", "-srcs", testpath/"testfile.swift", "-d", testpath/"GeneratedMocks.swift"
    assert_predicate testpath/"GeneratedMocks.swift", :exist?
    output = <<~EOS.gsub(/\s+/, "").strip
      ///
      /// @Generated by Mockolo
      ///
      public class FooMock: Foo {
        public init() { }
        public init(num: Int = 0) {
            self.num = num
        }

        public private(set) var numSetCallCount = 0
        public var num: Int = 0 { didSet { numSetCallCount += 1 } }

        public private(set) var barCallCount = 0
        public var barHandler: ((Float) -> (String))?
        public func bar(arg: Float) -> String {
            barCallCount += 1
            if let barHandler = barHandler {
                return barHandler(arg)
            }
            return ""
        }
      }
    EOS
    assert_equal output, shell_output("cat #{testpath/"GeneratedMocks.swift"}").gsub(/\s+/, "").strip
  end
end
