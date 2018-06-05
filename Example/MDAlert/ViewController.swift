//
//  ViewController.swift
//  MDAlert
//
//  Created by Chris Byatt on 05/15/2017.
//  Copyright (c) 2017 Chris Byatt. All rights reserved.
//

import UIKit
import MDAlert

class ViewController: UIViewController {

    @IBAction func showAlert(_ sender: UIButton) {
        
        // Alert with buttons
//        let alert = MDAlertController(title: "Wow", message: "It's an alert!", showsCancel: true)
//
//        alert.addAction(MDAlertAction(title: "OK", style: .default, action: nil))
//        alert.addAction(MDAlertAction(title: "OK", style: .destructive, action: nil))
//        alert.addAction(MDAlertAction(title: "OK", style: .cancel, action: nil))
//
//        alert.show()
        
        // Alert no buttons
//        let alert = MDAlertController(title: "Password reset", message: "Your request has been recieved, please check your email for instructions on resetting your password.")
//
//        alert.show()
        
        // Alert custom view no buttons
        let view = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 130))
        view.backgroundColor = .black

        let alert = MDAlertController(title: "Wow", message: "This is an alert", customView: view, showsCancel: true)

        alert.show()
        
        // Alert custom view with Buttons
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 130))
//        view.backgroundColor = .black
//
//        let alert = MDAlertController(title: "Wow", message: "This is an alert", customView: view, showsCancel: true)
//        alert.addAction(MDAlertAction(title: "OK", style: .default, action: nil))
//
//        alert.show()
    }
}

