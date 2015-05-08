//
//  SJView.swift
//  Learning Core Graphics
//
//  Created by Saurabh Jain on 5/5/15.
//  Copyright (c) 2015 Saurabh Jain. All rights reserved.
//

import UIKit

/*******************************
    Base view for init
*******************************/

class SJBaseView: UIView {
    
    init() {
        assert(false, "Use Init with Frame")
        super.init(frame: CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        backgroundColor = UIColor.whiteColor()
    }
}


/*******************************
        Rectangle
*******************************/

class SJRectangleView: SJBaseView {
    
    override func drawRect(rect: CGRect) {
        
        // Get the current context
        let context = UIGraphicsGetCurrentContext()
        
        // Dimensions to be drawn
        let rectangle = CGRect(x: 100, y: 100, width: 100, height: 50)
        
        // Rectangle 1
        createPath(context, rect: rectangle)
        CGContextSetRGBFillColor(context, 0, 0, 0.5, 0.5)
        CGContextDrawPath(context, kCGPathFill)
        
        // Rectangle 2
        CGContextTranslateCTM(context, 120, 0)
        createPath(context, rect: rectangle)
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
        CGContextSetLineWidth(context, 3.0)
        CGContextDrawPath(context, kCGPathStroke)
        
        // Rectangle 3
        CGContextTranslateCTM(context, -120, 100)
        createPath(context, rect: rectangle)
        CGContextDrawPath(context, kCGPathFillStroke)
        
        // Rectangle 4
        CGContextTranslateCTM(context, 120, 0)
        createPath(context, rect: rectangle)
        CGContextDrawPath(context, kCGPathStroke)
        createPath(context, rect: rectangle)
        CGContextDrawPath(context, kCGPathFill)
    }
    
    // Creates a rectangle path
    private func createPath(context: CGContextRef, rect: CGRect) {
        
        let x = rect.origin.x
        let y = rect.origin.y
        let width = rect.size.width
        let height = rect.size.height
        
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, x, y)
        CGContextAddLineToPoint(context, x + width, y)
        CGContextAddLineToPoint(context, x+width, y+height)
        CGContextAddLineToPoint(context, x, y+height)
        CGContextClosePath(context)
    }

}

/*******************************
        Aplha Rectangle
*******************************/

class SJAlphaRectangle: SJBaseView {
    
    var numberOfRects: Int = 6 {
        didSet {
            if numberOfRects > 0 {
                setNeedsDisplay()
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        // Rectangle to draw
        let rectangle = CGRect(x: 0, y: 0, width: 150, height: 100)
        
        // Angle to rotate by
        let rad: CGFloat = CGFloat(2 * M_PI / Double(numberOfRects))
        
        // Value to be deducted from the alpha
        let deduction: CGFloat = CGFloat(1.0 / Double(numberOfRects))
        
        // Get the current context
        let context = UIGraphicsGetCurrentContext()
        
        // Translate to middle of the view's bounds
        CGContextTranslateCTM(context, CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        
        // Alpha
        var alpha:CGFloat = 1
        
        // Number of rectangles to be drawn
        for var i = 0; i < numberOfRects; i++ {
            CGContextSetRGBFillColor(context, 1, 0, 0, alpha)
            CGContextFillRect(context, rectangle)
            
            // Key Step
            CGContextRotateCTM(context, rad)
            alpha -= deduction
        }
    }
}


/*******************************
            Lines
*******************************/

class SJLine: SJBaseView {
    
    override func drawRect(rect: CGRect) {
        
        // Get the current context
        let context = UIGraphicsGetCurrentContext()
        
        // Set the line width
        CGContextSetLineWidth(context, 4.0)
        
        // Set white color
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
        
        var arr: [CGFloat] = [12.0, 6.0, 5.0, 6.0, 5.0, 6.0]
        
        // Line 1 - Solid
        strokeline(context, startPoint: CGPoint(x: 0, y: 100))
        
        // Line 2
        CGContextSetLineDash(context, 0, arr, 2)
        strokeline(context, startPoint: CGPoint(x: 0, y: 150))
        
        // Line 3
        CGContextSetLineDash(context, 0, arr, 6)
        strokeline(context, startPoint: CGPoint(x: 0, y: 200))
        
        // Line 4
        CGContextSetLineDash(context, arr[0], arr, 6)
        strokeline(context, startPoint: CGPoint(x: 0, y: 250))
        
        // Line 5 - Solid
        CGContextSetLineDash(context, 0, nil, 0)
        strokeline(context, startPoint: CGPoint(x: 0, y: 300))
    }
    
    private func strokeline(context: CGContextRef, startPoint: CGPoint) {
        CGContextBeginPath(context)
        CGContextMoveToPoint(context, startPoint.x, startPoint.y)
        CGContextAddLineToPoint(context, startPoint.x + CGRectGetWidth(bounds), startPoint.y)
        CGContextDrawPath(context, kCGPathStroke)
    }
}

/*******************************
        Ratings - Star View
*******************************/
class SJRatingView: SJBaseView {
    
    private var numberOfStars = 5 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private override func setUp() {
        super.setUp()
        
        let width = CGRectGetWidth(bounds)
        let height = CGRectGetHeight(bounds)
        let starWidth = width/CGFloat(numberOfStars) - 2
        
        for var i = 0; i < numberOfStars; i++ {
            let xOffset:CGFloat = CGFloat(i * (Int(width)/numberOfStars))
            addSubview(SJStar(frame: CGRect(x: xOffset+2, y: 0, width: starWidth, height: height)))
        }
    }
    
    
    private class SJStar: UIView {
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        private func setUp() {
            backgroundColor = UIColor.whiteColor()
        }
        
        private override func drawRect(rect: CGRect) {
            
            let context = UIGraphicsGetCurrentContext()
            let width = CGRectGetWidth(bounds)
            let height = CGRectGetHeight(bounds)
            let side = CGFloat(Double(width/2)/cos(36*M_PI/180))
            
            CGContextSetRGBStrokeColor(context, 1, 0, 0, 1)
            CGContextSetRGBFillColor(context, 1, 0, 0, 1)
            
            let point1 = CGPointMake(0, 0)
            let point2 = CGPointMake(-width/2, CGFloat(Double(width/2)/tan(54*M_PI/180)))
            let point3 = CGPointMake(-side/2, height)
            let point4 = CGPointMake(side/2, height)
            let point5 = CGPointMake(width/2, CGFloat(Double(width/2)/tan(54*M_PI/180)))
            
            let points = [point1, point3, point5, point2, point4, point1]
            
            CGContextTranslateCTM(context, width/2, 0)
            CGContextMoveToPoint(context, point1.x, point1.y)
            CGContextAddLines(context, points, points.count)
            CGContextDrawPath(context, kCGPathFill)
        }
        
    }
}












