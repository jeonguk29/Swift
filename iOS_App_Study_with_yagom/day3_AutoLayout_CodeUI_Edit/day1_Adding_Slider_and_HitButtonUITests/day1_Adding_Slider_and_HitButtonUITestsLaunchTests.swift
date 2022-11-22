//
//  day1_Adding_Slider_and_HitButtonUITestsLaunchTests.swift
//  day1_Adding_Slider_and_HitButtonUITests
//
//  Created by 정정욱 on 2022/11/18.
//

import XCTest

final class day1_Adding_Slider_and_HitButtonUITestsLaunchTests: XCTestCase {

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
