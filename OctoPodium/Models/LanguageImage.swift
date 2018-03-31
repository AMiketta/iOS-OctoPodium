//
//  LanguageImage.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 04/12/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class LanguageImage : UIImage {

    class func loadFor(_ language: String) -> UIImage {
        if let image = UIImage(named: language.lowercased()) {
            return image
        } else {
            return #imageLiteral(resourceName: "Language")
        }
    }
    
    class func load(for language: String, orLanguageImageView languageImageView: ImageOrLetterView) -> UIImage {
        if language.isEmpty { return #imageLiteral(resourceName: "Language") }
        
        if let image = UIImage(named: language.lowercased()) {

            return image

        }

        UIGraphicsBeginImageContextWithOptions(languageImageView.bounds.size, false, 0.0)
        languageImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
    
}
