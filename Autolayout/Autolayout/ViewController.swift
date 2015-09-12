//
//  ViewController.swift
//  Autolayout
//
//  Created by Andriy Bas on 8/21/15.
//  Copyright © 2015 Andriy Bas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
 
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    var isSecure: Bool = false { didSet { updateUI() } }
    var loggedInUser: User? { didSet { updateUI() } }
    
    private func updateUI() {
        self.passwordField.secureTextEntry = isSecure
        passwordLabel.text = (isSecure ? "Secure " : "") + "Password"
    }
    
    @IBAction func changeSecurity() {
        isSecure = !isSecure
        
    }
    
    @IBAction func performLogin() {
        loggedInUser = User.login(emailField.text ?? "", password: passwordField.text ?? "")
        image = loggedInUser?.image
        
      
    }
    
    var image : UIImage? {
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                } else {
                    aspectRatioConstraint = nil
                }
            }
        }
        
        get {
            return imageView.image
        }
    }
    
    var aspectRatioConstraint : NSLayoutConstraint? {
        willSet {
            if let oldConstraint = aspectRatioConstraint {
                imageView.removeConstraint(oldConstraint)
            }
        }
        
        didSet {
            if let newConstraint = aspectRatioConstraint {
                imageView.addConstraint(newConstraint)
            }
        }
    }
    
    
}

extension User {
    var image : UIImage? {
        if let img = UIImage(named: self.name) {
            return img
        } else {
            return UIImage(named: "img1")
        }
    }
}

extension UIImage {
    var aspectRatio : CGFloat {
        return size.height != 0 ? size.width / size.height : 0;
    }
}

