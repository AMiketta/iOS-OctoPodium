//
//  OctoPodiumUITests.swift
//  OctoPodiumUITests
//
//  Created by Nuno Gonçalves on 22/11/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import XCTest

class OctoPodiumUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        setupSnapshot(app: app)
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBasicNavigationScreen() {

        let mainTabScreen = MainTabScreen(app: app, testCase: self)

        mainTabScreen
            .goToLanguagesScreen()
            .takeASnapshot(named: "01LanguagesScreen")
            .goToJavascriptRanking()
            .takeASnapshot(named: "02LanguageRankingScreen")
            .goToFacebookProfile()
            .takeASnapshot(named: "03FacebookScreen")

        mainTabScreen
            .goToTrendingScreen()
            .takeASnapshot(named: "04TrendingScreen")

        mainTabScreen
            .goToSettingsScreen()
            .goToGithubAccountScreen()
            .goToAddGithubAccountScreen()
            .takeASnapshot(named: "05AddGitHubAccountScreen")
    }
}
