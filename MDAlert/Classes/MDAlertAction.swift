//
//  MDAlertAction.swift
//  miDrive Insurance
//
//  Created by Chris Byatt on 08/06/2016.
//  Copyright © 2016 miDrive. All rights reserved.
//

import UIKit

public enum MDAlertActionStyle {
    case cancel, destructive, `default`
}

open class MDAlertAction: NSObject {
    
    open var action: ((MDAlertAction) -> Void)?
    open var button: UIButton!
    open var controller: MDAlertController! {
        didSet {
            setStyles()
        }
    }

    var customButton: Bool = false

    open var dismissAlert: Bool = true

    private var style: MDAlertActionStyle = .default
    
    convenience public init(title: String, style: MDAlertActionStyle, button: UIButton? = nil, action: ((MDAlertAction) -> Void)?) {
        self.init()
        
        self.style = style
        self.action = action

        self.button = UIButton()
        self.button.setTitle(title, for: UIControl.State())
    }

    convenience public init(button: UIButton, action: ((MDAlertAction) -> Void)?) {
        self.init()

        self.action = action
        self.button = button
        customButton = true
    }

    func setStyles() {
        if !customButton {
            switch style {
            case .cancel:
                button.backgroundColor = controller.actionCancelBackgroundColour
                button.setTitleColor(controller.actionCancelTitleColour, for: UIControl.State())
            case .destructive:
                button.backgroundColor = controller.actionDestructiveBackgroundColour
                button.setTitleColor(controller.actionDestructiveTitleColour, for: UIControl.State())
            default:
                button.backgroundColor = controller.actionDefaultBackgroundColour
                button.setTitleColor(controller.actionDefaultTitleColour, for: UIControl.State())
            }
        }

        button.titleLabel!.font = controller.actionTitleFont
    }
}
