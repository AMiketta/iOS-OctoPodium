//
//  Screen.swift
//  OctoPodiumUITests
//
//  Created by Nuno Gonçalves on 01/04/2018.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import XCTest

typealias ElementName = String
typealias CellIndex = Int

protocol Screen {

    var app: XCUIApplication { get }
    var testCase: XCTestCase { get }

    func waitUntilLoaded()

    static var screenName: String { get }
}

extension Screen {

    static var screenName: String {
        
        return String(describing: self)
    }

    @discardableResult
    func takeASnapshot(named name: String = Self.screenName) -> Self {

        snapshot(name: name)
        return self
    }
}
