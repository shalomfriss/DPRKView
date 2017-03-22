//
//  DPRKView.swift
//
//  Created by Shalom Friss on 03/21/2017
//  Copyright © 2017 Shalom Friss. All rights reserved.
//

import Foundation
import UIKit

class DPRKView: UIView, UIGestureRecognizerDelegate {
    
    let panGesture = UIPanGestureRecognizer()
    let pinchGesture = UIPinchGestureRecognizer()
    let rotGesture = UIRotationGestureRecognizer()
    
    var rtrans:CGAffineTransform?
    var strans:CGAffineTransform?
    
    var ox: CGFloat?
    var oy: CGFloat?
    var os: CGFloat?
    var orot: CGFloat?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup ()
    {
        self.backgroundColor = UIColor.red
        self.os = 1.0
        
        self.rtrans = self.transform
        self.strans = self.transform
        
        panGesture.addTarget(   self, action: #selector(DPRKView.panGestureHandler))
        pinchGesture.addTarget( self, action: #selector(DPRKView.pinchGestureHandler))
        rotGesture.addTarget(   self, action: #selector(DPRKView.rotationGestureHandler))
        
        self.addGestureRecognizer(panGesture)
        self.addGestureRecognizer(pinchGesture)
        self.addGestureRecognizer(rotGesture)
        
        pinchGesture.delegate = self
        rotGesture.delegate = self
    }
    
    func panGestureHandler ()
    {
        if panGesture.state == UIGestureRecognizerState.began {
            ox = self.center.x
            oy = self.center.y
        }
        
        let loc = panGesture.translation(in: self.superview)
        self.center = CGPoint(x: ox!+loc.x, y: oy!+loc.y)
    }
    
    func pinchGestureHandler ()
    {
        let scale = pinchGesture.scale*os!
        strans = CGAffineTransform(scaleX: scale, y: scale)
        self.transform = strans!.concatenating(rtrans!)
        
        if pinchGesture.state == UIGestureRecognizerState.ended {
            os = pinchGesture.scale*os!
        }
    }
    
    
    func rotationGestureHandler()
    {
        print("rot")
        let radians = CGFloat(atan2f(Float(self.transform.b), Float(self.transform.a)))
        
        if rotGesture.state == UIGestureRecognizerState.began {
            orot = radians
        }
        
        rtrans = CGAffineTransform(rotationAngle: orot! + rotGesture.rotation)
        self.transform = rtrans!.concatenating(self.strans!)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}