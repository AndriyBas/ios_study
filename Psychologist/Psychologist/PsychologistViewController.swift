//
//  ViewController.swift
//  Psychologist
//
//  Created by Andriy Bas on 8/17/15.
//  Copyright © 2015 Andriy Bas. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        log("init with nibName : \(nibNameOrNil) and bundle : \(nibBundleOrNil)")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        log("init with coder : \(aDecoder)" )
    }
    
    // MARK: Lige Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        log("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        log("didReceiveMemoryWarning")
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        log("viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        log("viewDidAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        log("viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        log("viewDidDisappear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        log("viewWillLayoutSubviews, bounds.size = (\(self.view.bounds.size))")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        log("viewDidLayoutSubviews, bounds.size = (\(self.view.bounds.size))")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        log("awakeFromNib")
    }
    
    
    
    // MARK: Actions
    @IBAction func nothingAction(sender: UIButton) {
        performSegueWithIdentifier("nothingIdentifier", sender: nil)
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationVC = segue.destinationViewController as? UIViewController
        if let navVC = destinationVC as? UINavigationController {
            destinationVC = navVC.visibleViewController
        }
        if let hvc = destinationVC as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                    case "sadIdentifier": hvc.happiness = 0
                    case "happyIdentifier": hvc.happiness = 100
                    case "mehIdentifier": hvc.happiness = 50
                    case "nothingIdentifier": hvc.happiness = 25
                    default : break
                }
            }
        }
    }
    
    func log(message : String) {
        print(message)
    }

}

