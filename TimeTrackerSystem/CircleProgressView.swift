//
//  CircleProgressView.swift
//
//
//  Created by Eric Rolf on 8/11/14.
//  Copyright (c) 2014 Eric Rolf, Cardinal Solutions Group. All rights reserved.
//

import UIKit

@objc @IBDesignable class CircleProgressView: UIView {

    struct Constants {
        let circleDegress = 360.0
        let minimumValue = 0.000001
        let maximumValue = 0.999999
        let ninetyDegrees = 90.0
        let twoSeventyDegrees = 270.0
        var contentView:UIView = UIView()
    }

     let constants = Constants()
     var internalProgress:Double = 0.0

     weak var displayLink: CADisplayLink?
     var destinationProgress: Double = 0.0

    @IBInspectable var progress: Double = 0.000001 {
        didSet {
            internalProgress = progress
            setNeedsDisplay()
        }
    }

    @IBInspectable var refreshRate: Double = 0.0 {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var clockwise: Bool = true {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var trackWidth: CGFloat = 10 {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var trackImage: UIImage? {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var trackBackgroundColor: UIColor = UIColor.grayColor() {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var trackFillColor: UIColor = UIColor.blueColor() {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var trackBorderColor:UIColor = UIColor.clearColor() {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var trackBorderWidth: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var centerFillColor: UIColor = UIColor.whiteColor() {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var centerImage: UIImage? {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var contentView: UIView {
        return self.constants.contentView
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)
        internalInit()
        self.addSubview(contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        internalInit()
        self.addSubview(contentView)
    }

    func internalInit() {
        let displayLink = CADisplayLink(target: self, selector: "displayLinkTick")
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        displayLink.frameInterval = 60
        displayLink.paused = true
        self.displayLink = displayLink
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)

        let innerRect = rect.insetBy(dx: trackBorderWidth, dy: trackBorderWidth)

        internalProgress = (internalProgress/1.0) == 0.0 ? constants.minimumValue : progress
        internalProgress = (internalProgress/1.0) == 1.0 ? constants.maximumValue : internalProgress
        internalProgress = clockwise ?
                                (-constants.twoSeventyDegrees + ((1.0 - internalProgress) * constants.circleDegress)) :
                                (constants.ninetyDegrees - ((1.0 - internalProgress) * constants.circleDegress))

        let context = UIGraphicsGetCurrentContext()

        // background Drawing
        let circlePath = UIBezierPath(ovalInRect: CGRect(x: innerRect.minX, y: innerRect.minY, width: innerRect.width, height: innerRect.height))
        if trackBackgroundColor != UIColor.clearColor() {
            trackBackgroundColor.setFill()
            circlePath.fill();
        }
        if trackBorderWidth > 0 {
            circlePath.lineWidth = trackBorderWidth
            trackBorderColor.setStroke()
            circlePath.stroke()
        }

        // progress Drawing
        let progressPath = UIBezierPath()
        let progressRect: CGRect = CGRect(x: innerRect.minX, y: innerRect.minY, width: innerRect.width, height: innerRect.height)
        let center = CGPoint(x: progressRect.midX, y: progressRect.midY)
        let radius = progressRect.width / 2.0
        let startAngle:CGFloat = clockwise ? CGFloat(-internalProgress * M_PI / 180.0) : CGFloat(constants.twoSeventyDegrees * M_PI / 180)
        let endAngle:CGFloat = clockwise ? CGFloat(constants.twoSeventyDegrees * M_PI / 180) : CGFloat(-internalProgress * M_PI / 180.0)

        progressPath.addArcWithCenter(center, radius:radius, startAngle:startAngle, endAngle:endAngle, clockwise:!clockwise)
        progressPath.addArcWithCenter(center, radius:radius-trackWidth, startAngle:endAngle, endAngle:startAngle, clockwise:clockwise)
        //progressPath.addLine(to: CGPoint(x: progressRect.midX, y: progressRect.midY))
        progressPath.closePath()

        CGContextSaveGState(context)

        progressPath.addClip()

        if let trackImage = trackImage {
            trackImage.drawInRect(innerRect)
        } else if trackFillColor != UIColor.clearColor() {
            trackFillColor.setFill()
            circlePath.fill()
        }

        CGContextRestoreGState(context)

        // center Drawing
        let centerPath = UIBezierPath(ovalInRect: CGRect(x: innerRect.minX + trackWidth, y: innerRect.minY + trackWidth, width: innerRect.width - (2 * trackWidth), height: innerRect.height - (2 * trackWidth)))

        if centerFillColor != UIColor.clearColor() {
            centerFillColor.setFill()
            centerPath.fill()
        }

        if let centerImage = centerImage {
            CGContextSaveGState(context)
            centerPath.addClip()
            centerImage.drawInRect(rect)
            CGContextRestoreGState(context)
        } else {
            let layer = CAShapeLayer()
            layer.path = centerPath.CGPath
            contentView.layer.mask = layer
        }
    }

    //MARK: - Progress Update

    func setProgress(newProgress: Double, animated: Bool) {

        if animated {
            destinationProgress = newProgress
            self.displayLink?.paused = false
        } else {
            progress = newProgress
            self.displayLink?.paused = true
        }
    }

    //MARK: - CADisplayLink Tick

    /*internal*/ func displayLinkTick() {

        let renderTime = refreshRate.isZero ? self.displayLink!.duration : refreshRate
        //print(" == \(progress)")
        if destinationProgress > progress {
            progress += renderTime
            if progress >= destinationProgress {
                progress = destinationProgress
            }
        }
        else if destinationProgress < progress {
            progress -= renderTime
            if progress <= destinationProgress {
                progress = destinationProgress
            }
        } else {
            self.displayLink?.paused = true
        }
    }


}
