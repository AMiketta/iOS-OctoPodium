//
//  GithubLoadingViewSnapshotTests.swift
//  OctoPodiumTests
//
//  Created by Nuno Gonçalves on 31/03/2018.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

@testable import OctoPodium
import FBSnapshotTestCase

final class GithubLoadingViewSnapshotTests: FBSnapshotTestCase {

    private let loadingView = GithubLoadingView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    override func getFolderName() -> String {

        return String(describing: type(of: loadingView))
    }

    override func setUp() {

        super.setUp()
        loadingView.backgroundColor = .white
    }

    func testBeggining() {

        FBSnapshotVerifyView(loadingView)
    }

    func test10Percent() {

        loadingView.render(with: .forceStatic(at: 10, offset: 30))
        FBSnapshotVerifyView(loadingView)
    }

    func test30Percent() {

        loadingView.render(with: .forceStatic(at: 30, offset: 30))
        FBSnapshotVerifyView(loadingView)
    }

    func test50Percent() {

        loadingView.render(with: .forceStatic(at: 50, offset: 30))
        FBSnapshotVerifyView(loadingView)
    }

    func test80Percent() {

        loadingView.render(with: .forceStatic(at: 80, offset: 30))
        FBSnapshotVerifyView(loadingView)
    }

    func test100Percent() {

        loadingView.render(with: .forceStatic(at: 100, offset: 30))
        FBSnapshotVerifyView(loadingView)
    }
}
