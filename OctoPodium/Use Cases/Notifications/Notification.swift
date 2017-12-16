//
//  Notification.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 29/03/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

class Notification : NSObject {
    
    private let errorDuration: TimeInterval = 0.75
    private let window = UIApplication.shared.keyWindow!
    private static let navigationBarHeight: CGFloat = 66
    private static let statusBarHeight: CGFloat = 20
 
    static let instance = Notification()

    private let height: CGFloat
    
    private override init() {

        self.height = Notification.calculatedHeight
    }

    private static var calculatedHeight: CGFloat {

        var height: CGFloat = navigationBarHeight

        //Damn... this code looks... awesome... not!
        if #available(iOS 11.0, *) { // joining the conditions doesn't seem to work
            if let topSafeAreaInset = UIApplication.shared.keyWindow?.safeAreaInsets.top,
                topSafeAreaInset > 0 {

                height = (navigationBarHeight + topSafeAreaInset)

            } else {

                height += statusBarHeight
            }
        } else {

            height += statusBarHeight
        }

        return height
    }
    
    var isDisplaying = false
    
    func display(_ message: String? = nil, alertType: AlertType) {
        if isDisplaying {
            return
        }
        isDisplaying = true
        
        let alertView = AlertView(frame: CGRect(x: 0, y: -80, width: window.width, height: height))
        alertView.setStyle(alertType)
        
        if let message = message {
            alertView.setMessage(message)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        alertView.addGestureRecognizer(tapGesture)
        
        window.addSubview(alertView)
        let windowWidth = window.frame.width
        
        UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {
                             alertView.frame = CGRect(x: 0, y: -20, width: windowWidth, height: self.height)
                           }, completion: { _ in
                                self.perform(#selector(self.dismiss(_:)), with: alertView, afterDelay: 1.25)
                           }
        )
    }
    
    @objc private func onTap(_ tapGesture: UITapGestureRecognizer) {
        dismiss(tapGesture.view!)
    }
    
    @objc func dismiss(_ view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            view.frame = view.frame.offsetBy(dx: 0, dy: -128)
            }, completion: { [weak self] _ in
                view.removeFromSuperview()
                self?.isDisplaying = false
            }
        )
    }

}
