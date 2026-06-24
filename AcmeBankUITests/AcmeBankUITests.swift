import XCTest

/// Bootstrap proof-of-life: verifies the UI-test target compiles and that
/// the app launches without crashing. Real XCUITest critical-flow tests
/// (login, transfer, sign-out) belong in feature stories.
final class AcmeBankUITests: XCTestCase {
    func test_appLaunches() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.state == .runningForeground, "App should be running in the foreground after launch")
    }
}
