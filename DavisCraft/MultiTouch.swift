//
//  MultiTouch.swift
//  DavisCraft
//
//  Created by Alex Chan on 10/11/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit
import SpriteKit


class MultiTouch: UIViewController,UITextFieldDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }

}
