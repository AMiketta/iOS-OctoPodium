//
//  LanguageCell.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 04/12/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell, NibReusable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageImageView: ImageOrLetterView!
    
    var language: String? {
        didSet {
            let lang = language ?? ""
            nameLabel.text = lang

            guard !lang.isEmpty else {
                languageImageView.render(with: .image(#imageLiteral(resourceName: "Language")))
                return
            }

            if let image = UIImage(named: lang.lowercased()) {

                languageImageView.render(with: .image(image))

            } else {
                languageImageView.render(with: .letter(character: lang.first!))
            }
        }
    }
}
