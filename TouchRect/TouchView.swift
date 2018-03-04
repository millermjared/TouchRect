//
//  TouchView.swift
//  TouchRect
//
//  Created by Mathew Miller on 3/3/18.
//  Copyright © 2018 Mathew Miller. All rights reserved.
//

import UIKit

class TouchView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static let eraserSize: CGFloat = 32.0
    var showRect = false
    var rectFrame = CGRect(x: 0.0, y: 0.0, width: eraserSize, height: eraserSize)
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        if showRect {
            context.setLineWidth(1.0)
            context.setStrokeColor(UIColor.lightGray.cgColor)
            let color = UIColor.lightGray.withAlphaComponent(0.1)
            context.setFillColor(color.cgColor)
            context.addRect(rectFrame)
            context.drawPath(using: .fillStroke)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showRect = true
        setNeedsDisplay(paddedRectFrame)
        let touch = touches.first
        startPoint = touch?.location(in: self)
        rectFrame.origin.x = startPoint!.x - TouchView.eraserSize / 2.0
        rectFrame.origin.y = startPoint!.y - TouchView.eraserSize / 2.0
        setNeedsDisplay(rectFrame)
    }
    
    var paddedRectFrame: CGRect {
        return CGRect(x: rectFrame.minX - 1.0, y: rectFrame.minY - 1.0, width: rectFrame.width + 2.0, height: rectFrame.height + 2.0)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startPoint = touch?.location(in: self)
        
        setNeedsDisplay(paddedRectFrame)
        
        rectFrame.origin.x = startPoint!.x - TouchView.eraserSize / 2.0
        rectFrame.origin.y = startPoint!.y - TouchView.eraserSize / 2.0
        
        setNeedsDisplay(rectFrame)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        showRect = false
        setNeedsDisplay(paddedRectFrame)

    }
    
//    -(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//    {
//    UITouch *touch = [touches anyObject];
//    startPoint = [touch locationInView:self];
//    rectFrame.origin.x = startPoint.x;
//    rectFrame.origin.y = startPoint.y;
//    }
//    - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//    {
//    UITouch *touch = [touches anyObject];
//    endPoint = [touch locationInView:self];
//    rectFrame.size.width = endPoint.y - startPoint.x;
//    rectFrame.size.height = endPoint.y - startPoint.x;
//    
//    [self setNeedsDisplay];
//    }
//    
//    - (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//    {
//    UITouch *touch = [touches anyObject];
//    endPoint = [touch locationInView:self];
//    rectFrame.size.width = endPoint.y - startPoint.x;
//    rectFrame.size.height = endPoint.y - startPoint.x;
//    
//    [self setNeedsDisplay];
//    }
    

}
