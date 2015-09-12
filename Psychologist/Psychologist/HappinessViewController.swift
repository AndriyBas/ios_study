//
//  HappinessViewController.swift
//  FashionWeek
//
//  Created by Andriy Bas on 8/15/15.
//  Copyright © 2015 Andriy Bas. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: Selector("scale:")))
        }
    }
    
    var happiness: Int = 100 { // 0 = very sad, 100 = ecstatic
        didSet {
            happiness = min(100, max(0, happiness))
            print("happiness = \(happiness)")
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.traitCollection.horizontalSizeClass.
        
    }
    
    private struct Constants {
        static let HappinessGstureScale: CGFloat = 4
    }

    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGstureScale)
            if (happinessChange != 0) {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    private func updateUI() {
        self.faceView?.setNeedsDisplay()
        self.title = "\(happiness)"
    }
    
    // MARK: FaceViewDataSource
    func smilenssForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50.0
    }
    
}
