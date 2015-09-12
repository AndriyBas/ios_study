//
//  SpaceViewController.swift
//  Autolayout
//
//  Created by Andriy Bas on 8/24/15.
//  Copyright © 2015 Andriy Bas. All rights reserved.
//

import UIKit

class SpaceViewController: UIViewController {
    
    override func viewDidLoad() {
//        
//        let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
//        let q = dispatch_get_global_queue(qos, 0)
//        
//        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? ImageViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "earthIdentifier" :
                    destVC.imageURL = Images.Earth
                    destVC.title = "Earth"
                case "cassiniIdentifier":
                    destVC.imageURL = Images.Cassini
                    destVC.title = "Cassini"
                case "saturnIdentifier":
                    destVC.imageURL = Images.Saturn
                    destVC.title = "Saturn"
                default:
                    destVC.imageURL = nil
                }
            }
        }
    }

}
