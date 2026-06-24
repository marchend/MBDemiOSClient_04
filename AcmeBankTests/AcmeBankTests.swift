import XCTest
@testable import AcmeBank

/// Bootstrap proof-of-life: verifies the unit-test target compiles and links
/// against the app module. Real behaviour tests belong in feature stories.
final class AcmeBankTests: XCTestCase {
    func test_contentView_initializes() {
        // Instantiating ContentView proves the module links correctly.
        // Do NOT assert on view rendering or layout — that belongs in feature stories.
        _ = ContentView()
    }
}
