//
//  GithubLoadingView.swift
//  GithubLoading
//
//  Created by Nuno Gonçalves on 29/11/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

final class GithubLoadingView: UIView {

    private typealias SELF = GithubLoadingView

    private let loadingIndicatorImageView = UIImageView.usingAutoLayout()
    private let staticImage: UIImageView = {

        let imageView = UIImageView.usingAutoLayout()
        imageView.image = #imageLiteral(resourceName: "GithubLoading-0.gif")
        return imageView
    }()
    
    private static let images = [#imageLiteral(resourceName: "GithubLoading-0.gif"), #imageLiteral(resourceName: "GithubLoading-1.gif"), #imageLiteral(resourceName: "GithubLoading-2.gif"), #imageLiteral(resourceName: "GithubLoading-3.gif"), #imageLiteral(resourceName: "GithubLoading-4.gif"), #imageLiteral(resourceName: "GithubLoading-5.gif"), #imageLiteral(resourceName: "GithubLoading-6.gif"), #imageLiteral(resourceName: "GithubLoading-7.gif")]
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)!
        commonInit()
    }

    private func commonInit() {
        addSubviews()
        addSubviewsConstraints()
    }

    private func addSubviews() {

        staticImage.hide()
        autoresizingMask = [.flexibleHeight, .flexibleWidth]

        addSubview(loadingIndicatorImageView)
        addSubview(staticImage)

        setupAnimation()
    }

    private func addSubviewsConstraints() {

        [loadingIndicatorImageView, staticImage].forEach {
            $0.constrain(width: 30, height: 30)
            $0.center(in: self)
        }
    }

    private func setupAnimation() {
        
        loadingIndicatorImageView.image = SELF.images[0]
        loadingIndicatorImageView.animationImages = SELF.images
        loadingIndicatorImageView.animationDuration = 0.75
    }

    func render(with configuration: Configuration) {

        switch configuration {
        case .animate:

            animate()
        case .stop:

            stop()
        case let .forceStatic(percentage, offset):
            self.forceStatic(at: percentage, offset: offset)
        }
    }

    private func animate() {

        loadingIndicatorImageView.startAnimating()
        staticImage.hide()
    }

    private func stop() {

        staticImage.show()
        loadingIndicatorImageView.stopAnimating()
    }

    private func forceStatic(at percentage: Int, offset: CGFloat) {

        staticImage.show()

        staticImage.isHidden = abs(offset) < 30
        loadingIndicatorImageView.isHidden = abs(offset) < 30

        let x = min((100 / SELF.images.count) * percentage / 100, 7)
        staticImage.image = SELF.images[x]
    }

    enum Configuration {

        case animate
        case stop
        case forceStatic(at: Int, offset: CGFloat)
    }
}
