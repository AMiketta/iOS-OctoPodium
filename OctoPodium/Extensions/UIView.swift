//
//  UIView.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 09/12/15.
//  Copyright © 2015 Nuno Gonçalves. All rights reserved.
//

import UIKit

extension UIView {
    func show() {
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }

    var width: CGFloat { get { return frame.width } }
    var height: CGFloat { get { return frame.height } }
   
    var halfWidth: CGFloat { get { return width / 2 } }
    var halfHeight: CGFloat { get { return height / 2 } }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set(newValue) {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set(newValue) {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set(newValue) {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    func removeAllSubviews() {
        for v in subviews  {
            v.removeFromSuperview()
        }
    }
    
    func applyGradient(_ colors: [UIColor]) {
        let gradient: CAGradientLayer = CAGradientLayer()
        setNeedsLayout()
        layoutIfNeeded()
        gradient.frame = bounds
        gradient.colors = colors.map { $0.cgColor }
        layer.addSublayer(gradient)
    }
    
    func animateInPath(_ path: UIBezierPath, withDuration duration: TimeInterval, onFinished: (() -> ())? = {}) {
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.rotationMode = kCAAnimationPaced
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        anim.duration = duration
        
        anim.path = path.cgPath
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            onFinished?()
        }
        layer.add(anim, forKey: "pathAnim")
    }

    static func usingAutoLayout() -> Self {

        let view = self.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension UIView {

    public func pinToBounds(of view: UIView,
                            topConstant: CGFloat = 0,
                            leadingConstant: CGFloat = 0,
                            bottomConstant: CGFloat = 0,
                            trailingConstant: CGFloat = 0) {

        self |- view
        view -| self
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant),
        ])
    }

    /// Creates and activates constraints based on the referring view. The default value for each constant is 0, but if you pass nil that constraint won't be added.
    /// - Parameters:
    ///   - view: the view to apply the constraints against
    ///   - top: top anchor constraint value
    ///   - leading: leading anchor constraint value
    ///   - bottom: bottom anchor constraint value
    ///   - trailing: trailing anchor constraint value
    public func constrain(referringTo view: UIView,
                          top: CGFloat? = 0,
                          leading: CGFloat? = 0,
                          bottom: CGFloat? = 0,
                          trailing: CGFloat? = 0) {

        var constraintsToActivate: [NSLayoutConstraint] = []

        if let topConstant = top {
            constraintsToActivate.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant))
        }

        if let leadingConstant = leading {
            constraintsToActivate.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingConstant))
        }

        if let bottomConstant = bottom {
            constraintsToActivate.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomConstant))
        }

        if let trailingConstant = trailing {
            constraintsToActivate.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailingConstant))
        }

        NSLayoutConstraint.activate(constraintsToActivate)
    }

    func constrain(width: CGFloat, height: CGFloat) {

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }

    func constrain(height: CGFloat) {

        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func center(in view: UIView) {

        NSLayoutConstraint.activate([

            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}

precedencegroup EffectfulComposition {
    associativity: left
}

infix operator |-|: EffectfulComposition
@discardableResult
func |-|(left: UIView, right: UIView) -> UIView {
    left.trailingAnchor.constraint(equalTo: right.leadingAnchor).isActive = true
    return right
}

infix operator -|: EffectfulComposition
@discardableResult
func -|(left: UIView, right: UIView) -> UIView {
    left.trailingAnchor.constraint(equalTo: right.trailingAnchor).isActive = true
    return right
}

infix operator |-: EffectfulComposition
@discardableResult
func |-(left: UIView, right: UIView) -> UIView {
    left.leadingAnchor.constraint(equalTo: right.leadingAnchor).isActive = true
    return right
}

