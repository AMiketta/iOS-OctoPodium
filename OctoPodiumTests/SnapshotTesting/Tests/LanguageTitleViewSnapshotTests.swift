//
//  LanguageTitleViewSnapshotTests.swift
//  OctoPodiumTests
//
//  Created by Nuno Gonçalves on 01/04/2018.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

@testable import OctoPodium
import FBSnapshotTestCase

final class LanguageTitleViewSnapshotTests: FBSnapshotTestCase {

    private let languageTitle = LanguageTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))

    override func getFolderName() -> String {

        return String(describing: type(of: languageTitle))
    }

    override func setUp() {

        super.setUp()
//        recordMode = true
    }

    func testWithJavascript() {

        languageTitle.render(with: "Javascript")
        FBSnapshotVerifyView(languageTitle)
    }

    func testWithUnknown() {

        languageTitle.render(with: "Unknown")
        FBSnapshotVerifyView(languageTitle)
    }

    func testWithEmpty() {

        languageTitle.render(with: "")
        FBSnapshotVerifyView(languageTitle)
    }
}
