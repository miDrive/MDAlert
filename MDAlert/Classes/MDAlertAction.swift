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

    private var style: MDAlertActionStyle = .default
    
    convenience public init(title: String, style: MDAlertActionStyle, button: UIButton? = nil, action: ((MDAlertAction) -> Void)?) {
        self.init()
        
        self.style = style
        self.action = action

        self.button = UIButton()
        self.button.setTitle(title, for: UIControlState())
    }

    convenience public init(button: UIButton, action: ((MDAlertAction) -> Void)?) {
        self.init()

        self.action = action
        self.button = button
    }

    func setStyles() {
        switch style {
        case .cancel:
            button.backgroundColor = controller.actionCancelBackgroundColour
            button.setTitleColor(controller.actionCancelTitleColour, for: UIControlState())
        case .destructive:
            button.backgroundColor = controller.actionDestructiveBackgroundColour
            button.setTitleColor(controller.actionDestructiveTitleColour, for: UIControlState())
        default:
            button.backgroundColor = controller.actionDefaultBackgroundColour
            button.setTitleColor(controller.actionDefaultTitleColour, for: UIControlState())
        }

        button.titleLabel!.font = controller.actionTitleFont
    }
}
