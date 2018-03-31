//
//  ImageOrLetterViewSnapshotTests.swift
//  OctoPodiumTests
//
//  Created by Nuno Gonçalves on 31/03/2018.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

@testable import OctoPodium
import FBSnapshotTestCase

final class ImageOrLetterViewSnapshotTests: FBSnapshotTestCase {

    private let imageOrLetter = ImageOrLetterView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))

    override func getFolderName() -> String {

        return String(describing: type(of: imageOrLetter))
    }

    override func setUp() {

        super.setUp()
    }

    func testWithImage() {

        imageOrLetter.render(with: .image(#imageLiteral(resourceName: "swift")))
        FBSnapshotVerifyView(imageOrLetter)
    }

    func testWithCharacter() {

        imageOrLetter.render(with: .letter(character: "C"))
        FBSnapshotVerifyView(imageOrLetter)
    }
}

