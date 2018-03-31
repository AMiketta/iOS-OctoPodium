//
//  LanguageTitleView.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 03/12/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

class LanguageTitleView: UIView {

    private let languageImageView = ImageOrLetterView.usingAutoLayout()
    private let label: UILabel = {

        let label = UILabel.usingAutoLayout()
        label.textColor = .white
        label.minimumScaleFactor = 0.5
        label.font = UIFont.TitilliumWeb.bold.ofSize(17)

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {

        addSubviews()
        addSubviewsConstraints()
    }

    private func addSubviews() {

        addSubview(languageImageView)
        addSubview(label)
    }

    private func addSubviewsConstraints() {

        languageImageView.constrain(width: 30, height: 30)

        [languageImageView, label].forEach { $0.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true }

        self |- languageImageView
        languageImageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -5).isActive = true
        label -| self
    }

    func render(with language: String) {

        label.text = language

        guard !language.isEmpty else {
            languageImageView.render(with: .image(#imageLiteral(resourceName: "Language")))
            return
        }

        if let image = UIImage(named: language.lowercased()) {

            languageImageView.render(with: .image(image))

        } else {
            languageImageView.render(with: .letter(character: language.first!))
        }
    }
}
