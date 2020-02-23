import XCTest

class WiremockExampleUITests: XCTestCase {

    var application: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    func testDataIsLoaded() {
        let repositoryName = application.tables.cells.staticTexts["awesome-ios"]
        let repositoryLoaded = repositoryName.waitForExistence(timeout: 2)
        XCTAssertTrue(repositoryLoaded)
    }
}
