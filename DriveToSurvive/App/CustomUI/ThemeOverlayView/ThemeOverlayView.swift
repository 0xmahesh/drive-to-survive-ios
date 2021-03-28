//
//  ThemeOverlayView.swift
//  DriveToSurvive
//
//  Created by Mahesh De Silva on 3/29/21.
//
import UIKit

class ThemeOverlayView: UIView {

    var overlayView = UIView()
    let maskLayer = CAShapeLayer()
    var initXOffset:CGFloat = 0
    var initYOffset:CGFloat = 0
    var initDiameter:CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    init(snapshotViews: [UIView],
         frame: CGRect,
         xOffset: CGFloat,
         yOffset: CGFloat,
         startDiameter: CGFloat,
         endDiameter:CGFloat,
         duration:Double) {

        super.init(frame: frame)

        self.isUserInteractionEnabled = false
        self.overlayView.isUserInteractionEnabled = false
        let beforeSnapshot = snapshotViews[0]
        overlayView = beforeSnapshot
        overlayView.frame = frame

        let padding:CGFloat = 50

        let startDiameter = startDiameter + padding
        let endDiameter = endDiameter + padding

        initXOffset = xOffset
        initYOffset = yOffset
        initDiameter = endDiameter

        let ovalFrame1 = CGRect(x:xOffset-(startDiameter/2),
                                y:yOffset-(startDiameter/2),
                                width:startDiameter,
                                height:startDiameter)

        let ovalFrame2 = CGRect(x:xOffset-(endDiameter/2),
                                y:yOffset-(endDiameter/2),
                                width:endDiameter,
                                height:endDiameter)


        let path = UIBezierPath(ovalIn: ovalFrame1)
        let path2 = UIBezierPath(ovalIn: ovalFrame2)

        maskLayer.backgroundColor = UIColor.clear.cgColor

        path.append(UIBezierPath(rect: self.bounds))
        path2.append(UIBezierPath(rect: self.bounds))

        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        maskLayer.path = path.cgPath
        CATransaction.commit()

        CATransaction.begin()
        
        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = path.cgPath
        anim.toValue = path2.cgPath
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        anim.fillMode = CAMediaTimingFillMode.forwards
        anim.isRemovedOnCompletion = false
        
        CATransaction.setCompletionBlock{ [weak self] in
            snapshotViews.forEach {
                $0.removeFromSuperview()
            }
           }
        
        maskLayer.add(anim, forKey: nil)
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        self.addSubview(overlayView)

    }

    func animateTo(xOffset: CGFloat,
                   yOffset: CGFloat,
                   endDiameter:CGFloat,
                   duration:Double) {

        let padding:CGFloat = 50

        let startDiameter = initDiameter
        let endDiameter = endDiameter + padding

        let ovalFrame1 = CGRect(x:initXOffset-(startDiameter/2),
                                y:initYOffset-(startDiameter/2),
                                width:startDiameter,
                                height:startDiameter)

        let ovalFrame2 = CGRect(x:xOffset-(endDiameter/2),
                                y:yOffset-(endDiameter/2),
                                width:endDiameter,
                                height:endDiameter)

        initXOffset = xOffset
        initYOffset = yOffset

        let path = UIBezierPath(ovalIn: ovalFrame1)
        let path2 = UIBezierPath(ovalIn: ovalFrame2)

        path.append(UIBezierPath(rect: self.bounds))
        path2.append(UIBezierPath(rect: self.bounds))

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        maskLayer.path = path.cgPath
        CATransaction.commit()

        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = path.cgPath
        anim.toValue = path2.cgPath
        anim.duration = duration
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        anim.fillMode = CAMediaTimingFillMode.forwards
        anim.isRemovedOnCompletion = false
        maskLayer.add(anim, forKey: nil)

        initDiameter = endDiameter

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
