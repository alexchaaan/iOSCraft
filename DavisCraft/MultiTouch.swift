//
//  MultiTouch.swift
//  DavisCraft
//
//  Created by Alex Chan on 10/11/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit
import SpriteKit


class MultiTouch: UIViewController {

    
    var boxView: UIView!
    var snapBehaviour : UISnapBehavior!
    var dynAnimator: UIDynamicAnimator!

    @IBOutlet var Spaceship: UIImageView!
    /*@IBAction func handleTap(sender: UITapGestureRecognizer) {
        
    
        let tapPoint: CGPoint = sender.locationInView(view)
        if (snapBehaviour != nil) {
            dynAnimator.removeBehavior(snapBehaviour)
        }
        
        snapBehaviour = UISnapBehavior(item: boxView, snapToPoint: tapPoint)
        dynAnimator.addBehavior(snapBehaviour)
    }*/
    
    @IBAction func handleTap(recognizer:UITapGestureRecognizer) {
        let location = recognizer.locationInView(self.view)
        Spaceship.center = location
        
        //SOUND
        let sound = AVAudioPlayerPool.returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd("explode.wav", subdir: "misc")
        sound?.prepareToPlay()
        sound?.play()
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
    }

  
    /* override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let theTouch = touches.anyObject() as UITouch
        var startPoint = theTouch.locationInView(self.view)
    
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        let theTouch = touches.anyObject() as UITouch
        
        var touchLocation = theTouch.locationInView(self.view)

    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let theTouch = touches.anyObject() as UITouch
        
        var endPoint = theTouch.locationInView(self.view)

    }
*/
    
    

}
