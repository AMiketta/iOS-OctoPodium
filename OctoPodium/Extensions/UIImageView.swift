//
//  UIImageView.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 13/05/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    
    func fetchAndLoad(_ url: String, onFinished: @escaping () -> () = {}) {

        guard let url = URL(string: url) else { return onFinished() }

        Nuke.loadImage(with: url, into: self) { (result, success) in

            if case let .success(image) = result {

                self.image = image
            }

            onFinished()
        }
    }
}
