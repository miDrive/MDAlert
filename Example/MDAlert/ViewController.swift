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
        let alert = MDAlertController(title: "Wow", message: "It's an alert!", showsCancel: true)

        alert.addAction(MDAlertAction(title: "OK", style: .default, action: nil))
        alert.addAction(MDAlertAction(title: "OK", style: .destructive, action: nil))
        alert.addAction(MDAlertAction(title: "OK", style: .cancel, action: nil))

        alert.show()
    }
}

