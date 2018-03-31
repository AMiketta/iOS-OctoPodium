//
//  ImageOrLetterView.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 11/01/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

import UIKit

class ImageOrLetterView : UIView {
    
    private let imageView = UIImageView.usingAutoLayout()
    private let label: UILabel = {

        let label = UILabel.usingAutoLayout()
        label.textColor = .white
        label.backgroundColor = UIColor(hex: 0x2F9DE6)
        label.font = UIFont.TitilliumWeb.bold.ofSize(17)
        label.cornerRadius = 15
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
//    var language: Language? {
//        didSet {
//            setLanguageIconOrLetter()
//        }
//    }

    override init(frame: CGRect) {

        super.init(frame: frame)

        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        commonInit()
    }
    
    func commonInit() {

        addSubviews()
        addSubviewsConstraints()
    }

    private func addSubviews() {

        addSubview(label)
        addSubview(imageView)
    }

    private func addSubviewsConstraints() {

        [label, imageView].forEach {
            $0.center(in: self)
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        }
    }

    enum Configuration {

        case letter(character: Character)
        case image(_: UIImage)
    }

    func render(with configuration: Configuration) {

        switch configuration {

        case let .letter(letter):

            imageView.hide()
            label.show()
            label.text = "\(letter)"

        case let .image(image):

            imageView.image = image
            imageView.show()
            label.hide()
        }
    }

//    private func setLanguageIconOrLetter() {
//        if var lang = language {
//            if lang == "" { lang = "Language" }
//            if let image = UIImage(named: lang.lowercased()) {
//                imageView.image = image
//                imageView.show()
//                label.hide()
//            } else {
//                imageView.hide()
//                label.show()
//                label.text = "\(lang.first!)"
//            }
//        } else {
//            label.text = " "
//            label.show()
//        }
//    }
}
