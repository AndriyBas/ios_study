//
//  FaceView.swift
//  FashionWeek
//
//  Created by Andriy Bas on 8/15/15.
//  Copyright © 2015 Andriy Bas. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
    func smilenssForFaceView(sender: FaceView) -> Double?
}

@IBDesignable
class FaceView: UIView {
    
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    
    weak var dataSource: FaceViewDataSource?
    
    var faceCenter: CGPoint {
        return convertPoint(self.center, fromView: self.superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private struct Scaling {
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMonthHeightRatio: CGFloat = 3
        static let FaceRadiusToMonthOffsetRatio: CGFloat = 3
    }

    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMonthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMonthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
        
    }
    
    func scale(gesture : UIPinchGestureRecognizer) {
        if gesture.state == UIGestureRecognizerState.Changed {
            scale *= gesture.scale
            gesture.scale = CGFloat(1)
        }
    }
    
    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        let smileness = self.dataSource?.smilenssForFaceView(self) ?? 0.0
        let smilePath = bezierPathForSmile(smileness)
        smilePath.stroke()
    }
    
    private func setUp() {
//        self.contentMode = UIViewContentMode.Redraw
    }

}
