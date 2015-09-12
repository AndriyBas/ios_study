//
//  DiagnoseHappinessViewController.swift
//  Psychologist
//
//  Created by Andriy Bas on 8/18/15.
//  Copyright © 2015 Andriy Bas. All rights reserved.
//

import UIKit

class DiagnoseHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory : [Int] {
        get { return userDefaults.objectForKey(History.DefaultsKey) as? [Int] ?? [] }
        set { userDefaults.setObject(newValue, forKey: History.DefaultsKey)  }
    }
    
    private struct History {
        static let SegueIdentifier = "showDiagnosticHistory"
        static let DefaultsKey = "DiagnoseHappinnessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    tvc.text = "\(diagnosticHistory)"
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                }
            default: break
            }
        }
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
