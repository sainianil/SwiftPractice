//
//  TimerView.swift
//  TimeTrackerSystem
//
//  Created by Anil Saini on 4/9/17.
//  Copyright © 2017 saini.com. All rights reserved.
//

import UIKit

class TimerView: UIView {

    var timerLayer: CAShapeLayer!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        // Use UIBezierPath as an easy way to create the CGPath for the layer.
        // The path should be the entire circle.
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        
        // Setup the CAShapeLayer with the path, colors, and line width
        timerLayer = CAShapeLayer()
        timerLayer.path = circlePath.CGPath
        timerLayer.fillColor = UIColor.clearColor().CGColor
        timerLayer.strokeColor = UIColor.redColor().CGColor
        timerLayer.lineWidth = 5.0;
        
        // Don't draw the circle initially
        timerLayer.strokeEnd = 0.0
        
        // Add the circleLayer to the view's layer's sublayers
        layer.addSublayer(timerLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateCircle(duration: NSTimeInterval) {
        // We want to animate the strokeEnd property of the circleLayer
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = duration
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        timerLayer.strokeEnd = 1.0
        
        // Do the actual animation
        timerLayer.addAnimation(animation, forKey: "animateCircle")
    }
    
//    override func drawRect(rect: CGRect) {
//        // Get the Graphics Context
//        let context = UIGraphicsGetCurrentContext();
//        
//        // Set the circle outerline-width
//        CGContextSetLineWidth(context, 5.0);
//        
//        // Set the circle outerline-colour
//        UIColor.redColor().set()
//        
//        // Create Circle
//        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
//        
//        // Draw
//        CGContextStrokePath(context);
//    }
}
