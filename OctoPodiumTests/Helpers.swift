//
//  Helpers.swift
//  OctoPodiumTests
//
//  Created by Nuno Gonçalves on 31/03/2018.
//  Copyright © 2018 Nuno Gonçalves. All rights reserved.
//

import Foundation

func waitSync(for timeInterval: TimeInterval) {

    RunLoop.main.run(until: Date(timeIntervalSinceNow: timeInterval))
}
