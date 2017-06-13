//
//  MDAlertView.swift
//  Pods
//
//  Created by Chris Byatt on 27/07/2016.
//
//

import UIKit

class MDAlertView: UIViewController {

    var controller: MDAlertController!

    var image: UIImage?

    var titleMessage: String!
    var bodyMessage: String!
    var customView: UIView?

    var showsCancel: Bool!

    var actions = [MDAlertAction]()

    @IBOutlet var imageView: UIImageView!

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    @IBOutlet var customViewHolder: UIView!
    
    @IBOutlet var alertView: UIView!
    @IBOutlet var spacerView: UIView!
    @IBOutlet private var bodyView: UIView!
    @IBOutlet var buttonView: UIStackView!
    @IBOutlet var buttonSpacerView: UIView!

    @IBOutlet var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        setStyles()
    }
    
    func setup() {
        self.alertView.alpha = 0.0

        titleLabel.text = titleMessage
        bodyLabel.text = bodyMessage

        cancelButton.isHidden = !showsCancel

        if let image = image {
            imageView.isHidden = false
            imageView.image = image
            spacerView.isHidden = true
        }

        if let customView = customView {
            customViewHolder.isHidden = false
            customView.translatesAutoresizingMaskIntoConstraints = false

            customViewHolder.addSubview(customView)
            customViewHolder.addConstraint(customView.topAnchor.constraint(equalTo: customViewHolder.topAnchor))
            customViewHolder.addConstraint(customView.leftAnchor.constraint(equalTo: customViewHolder.leftAnchor))
            customViewHolder.addConstraint(customView.bottomAnchor.constraint(equalTo: customViewHolder.bottomAnchor))
            customViewHolder.addConstraint(customView.rightAnchor.constraint(equalTo: customViewHolder.rightAnchor))

            if bodyMessage == nil {
                bodyLabel.isHidden = true
            }
        }

        for action in actions {
            buttonSpacerView.isHidden = true
            buttonView.isHidden = false
            buttonView.addArrangedSubview(action.button)
        }
    }

    func setStyles() {
        bodyView.layer.cornerRadius = controller.alertCornerRadius
        bodyView.backgroundColor = controller.alertBackgroundColour

        titleLabel.font = controller.titleFont
        titleLabel.textColor = controller.titleColour

        bodyLabel.font = controller.bodyFont
        bodyLabel.textColor = controller.bodyColour

        cancelButton.titleLabel!.font = controller.actionTitleFont

        buttonView.addConstraint(NSLayoutConstraint(item: self.buttonView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: (CGFloat(actions.count) * controller.actionHeight)))
    }

    @IBAction func pressedCancel(_ sender: UIButton) {
        controller.dismiss(nil)
    }
}

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    public subscript(safe index: Index) -> _Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
