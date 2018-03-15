//
//  MDAlertController.swift
//  miDrive Insurance
//
//  Created by Chris Byatt on 08/06/2016.
//  Copyright © 2016 miDrive. All rights reserved.
//

import UIKit

open class MDAlertController: NSObject {
    
    fileprivate var alertViewController: MDAlertView!

    open var alertBackgroundColour: UIColor = MDAlertViewDefaults.alertBackgroundColour
    open var alertCornerRadius: CGFloat = MDAlertViewDefaults.alertCornerRadius

    open var titleFont: UIFont = MDAlertViewDefaults.titleFont
    open var bodyFont: UIFont = MDAlertViewDefaults.bodyFont

    open var titleColour: UIColor = MDAlertViewDefaults.titleColour
    open var bodyColour: UIColor = MDAlertViewDefaults.bodyColour

    open var actionHeight: CGFloat = MDAlertViewDefaults.alertButtonHeight

    open var actionDefaultBackgroundColour: UIColor = MDAlertViewDefaults.actionDefaultBackgroundColour
    open var actionCancelBackgroundColour: UIColor = MDAlertViewDefaults.actionCancelBackgroundColour
    open var actionDestructiveBackgroundColour: UIColor = MDAlertViewDefaults.actionDestructiveBackgroundColour

    open var actionDefaultTitleColour: UIColor = MDAlertViewDefaults.actionDefaultTitleColour
    open var actionCancelTitleColour: UIColor = MDAlertViewDefaults.actionCancelTitleColour
    open var actionDestructiveTitleColour: UIColor = MDAlertViewDefaults.actionDestructiveTitleColour

    open var actionTitleFont: UIFont = MDAlertViewDefaults.actionTitleFont
    
    public init(title: String, message: String? = nil, customView: UIView? = nil, showsCancel: Bool = true) {
        super.init()
        
        let podBundle = Bundle(for: self.classForCoder)
        if let bundleURL = podBundle.url(forResource: "MDAlert", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) {
            let storyboard = UIStoryboard(name: "MDAlert", bundle: bundle)
            let alertView = storyboard.instantiateViewController(withIdentifier: "MDAlert") as! MDAlertView
            alertView.controller = self
            self.alertViewController = alertView
        
            self.alertViewController.titleMessage = title
            self.alertViewController.bodyMessage = message
            alertViewController.customView = customView
            alertViewController.showsCancel = showsCancel

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }

    public init(image: UIImage, title: String, message: String? = nil, customView: UIView? = nil, showsCancel: Bool = true) {
        super.init()

        let podBundle = Bundle(for: self.classForCoder)
        if let bundleURL = podBundle.url(forResource: "MDAlert", withExtension: "bundle"), let bundle = Bundle(url: bundleURL) {
            let storyboard = UIStoryboard(name: "MDAlert", bundle: bundle)
            let alertView = storyboard.instantiateViewController(withIdentifier: "MDAlert") as! MDAlertView
            alertView.controller = self

            alertViewController = alertView

            alertViewController.image = image
            alertViewController.titleMessage = title
            alertViewController.bodyMessage = message
            alertViewController.customView = customView
            alertViewController.showsCancel = showsCancel

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open func addAction(_ action: MDAlertAction) {
        action.controller = self
        action.button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        alertViewController.actions.append(action)
    }
    
    open func show() {
        if let topViewController = UIApplication.topViewController() {
            self.alertViewController.modalPresentationStyle = .overCurrentContext
            topViewController.present(alertViewController, animated: false, completion: {
                self.insertAlert()
            })
        }
    }
    
    func dismiss(_ action: (() -> ())?) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
            self.alertViewController.alertView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.alertViewController.view.alpha = 0.0
            }, completion: { finished in
                self.alertViewController.dismiss(animated: false, completion: {
                    if let action = action {
                        action()
                    }
                })
        })
    }
    
    @objc fileprivate func buttonPressed(_ button: UIButton) {
        
        if let buttonIndex = self.alertViewController.buttonView.subviews.index(of: button) {
            let action = self.alertViewController.actions[buttonIndex]
            if let pressedAction = action.action {
                if action.dismissAlert {
                    self.dismiss({
                        pressedAction(action)
                    })
                } else {
                    pressedAction(action)
                }
            } else {
                self.dismiss(nil)
            }
        }
    }
    
    fileprivate func insertAlert() {
        self.alertViewController.alertView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.alertViewController.alertView.center = self.alertViewController.view.center
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.alertViewController.view.alpha = 1.0
            self.alertViewController.alertView.alpha = 1.0
            self.alertViewController.alertView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let info = notification.userInfo {
            let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

            alertViewController.viewMidConstraint.constant = -keyboardFrame.size.height

            if #available(iOS 11.0, *) {
                alertViewController.viewMidConstraint.constant = -keyboardFrame.size.height
            }

            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: {
//                self.alertViewController.layoutIfNeeded()
            }, completion: nil)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        alertViewController.viewMidConstraint.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations: {
//            self.alertViewController.layoutIfNeeded()
        }, completion: nil)
    }
}

extension UIApplication {
    class func topViewController(_ base: UIViewController? = UIApplication.shared.delegate!.window!!.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}
