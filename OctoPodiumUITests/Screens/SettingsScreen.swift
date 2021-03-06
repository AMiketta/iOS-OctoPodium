//
//  SettingsScreen.swift
//  OctoPodiumUITests
//
//  Created by Nuno Gonçalves on 01/04/2018.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import XCTest

struct SettingsScreen: Screen {

    let app: XCUIApplication
    let testCase: XCTestCase

    init(app: XCUIApplication, testCase: XCTestCase) {

        self.app = app
        self.testCase = testCase
        self.waitUntilLoaded()
    }

    func waitUntilLoaded() {

    }

    private var table: XCUIElementQuery {
        return app.tables
    }

    private var githubAccountCellItem: XCUIElement {

        return table.cells.element(boundBy: .githubAccountIndex)
    }

    @discardableResult
    func goToGithubAccountScreen() -> GithubAccountScreen {

        githubAccountCellItem.tap()

        return GithubAccountScreen(app: app, testCase: testCase)
    }
}

private extension CellIndex {

    static let githubAccountIndex = 0
}
