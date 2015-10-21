//
//  Tile.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/12/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit


class Tile: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let tile = MapRender(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        view.addSubview(tile)*/
        
        
        
        //add a Subview that is the size of the screen
        //works for different devices
        
        let (_, height, width ) = MapRender().readMap()
        //        let screen = MapRender(frame: CGRectMake(0, 0, CGFloat(width * 32), CGFloat(height * 32)))
        //view.addSubview(screen)
        let screen = MapRender(frame: CGRectMake(0, 0, CGFloat(height * 32), CGFloat(width * 32)))
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = screen.bounds.size
        scrollView.backgroundColor = UIColor.blackColor()
        scrollView.scrollRectToVisible(CGRect(x: 2500, y: 1600, width: scrollView.frame.width, height: scrollView.frame.height), animated: true)
        scrollView.addSubview(screen)
        view.addSubview(scrollView)
        //        scrollView.userInteractionEnabled = false //this disables the scrolling, but lets touches began work.
        //Gesture Recognizers
        let tapRec = UITapGestureRecognizer()
        //let panRec = UIPanGestureRecognizer()
        tapRec.addTarget(self, action: "tappedView:")
        //panRec.addTarget(self, action: "panView:")
        scrollView.addGestureRecognizer(tapRec)
        
        //scrollView.addGestureRecognizer(panRec)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedView(recognizer:UITapGestureRecognizer) {
        let sound = AVAudioPlayerPool.returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd("thunk.wav", subdir: "misc")
        sound?.prepareToPlay()
        sound?.play()
    }
    
    /*func panView(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }*/
    
}





