//
//  _023_01_17_DarinBurch__NYCSchoolsUITestsLaunchTests.swift
//  2023_01_17-DarinBurch--NYCSchoolsUITests
//
//  Created by Mapspot on 1/17/23.
//

import XCTest

class _023_01_17_DarinBurch__NYCSchoolsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
