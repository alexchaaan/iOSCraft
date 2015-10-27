//
//  Tile.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/12/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit
import SpriteKit

class Tile: UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let tile = MapRender(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        view.addSubview(tile)*/
        
        view.backgroundColor = UIColor.blackColor()
        
        //add a Subview that is the size of the screen
        //works for different devices
        
        let (_, height, width ) = MapRender().readMap()
        //        let screen = MapRender(frame: CGRectMake(0, 0, CGFloat(width * 32), CGFloat(height * 32)))
        //view.addSubview(screen)
        let theMap = MapRender(frame: CGRectMake(0, 0, CGFloat(height * 32), CGFloat(width * 32)))
        let miniMap = MiniMapRender(frame:CGRectMake(10, 20, view.bounds.size.width / 4 , view.bounds.size.height - 20))
        var battleField: UIScrollView!
        
        // the size of viewport is the 3/4 of the screen - 1/4 for the side bar panel.
        battleField = UIScrollView(frame: CGRectMake(view.bounds.size.width / 4, 0, view.bounds.size.width * 3 / 4, view.bounds.size.height))
        battleField.contentSize = theMap.bounds.size
        battleField.backgroundColor = UIColor.blackColor()
        battleField.scrollRectToVisible(CGRect(x: 2500, y: 1600, width: battleField.frame.width, height: battleField.frame.height), animated: true)
        battleField.addSubview(theMap)
        view.addSubview(battleField)
        
        var sidePanel: UIView!
        
        sidePanel = UIView(frame: CGRectMake(0, 0, view.bounds.size.width / 4, view.bounds.size.height))
        sidePanel.backgroundColor = UIColor.blackColor()
        //sidePanel.scrollRectToVisible(CGRect(x: 2500, y: 1600, width: sidePanel.frame.width, height: sidePanel.frame.height), animated: true)
        sidePanel.addSubview(miniMap)
        view.addSubview(sidePanel)
        //        scrollView.userInteractionEnabled = false //this disables the scrolling, but lets touches began work.
        //Gesture Recognizers
        let tapRec = UITapGestureRecognizer()
        //let panRec = UIPanGestureRecognizer()
        tapRec.addTarget(self, action: "tappedView:")
        //panRec.addTarget(self, action: "panView:")
        battleField.addGestureRecognizer(tapRec)
        
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





