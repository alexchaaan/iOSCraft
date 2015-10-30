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

        //MAP
        let a = MapRenderer()
        a.RetrieveFromDat()
        view.backgroundColor = UIColor.blackColor()
        let (_, width, height ) = MapRender().readMap()
        let theMap = MapRender(frame: CGRectMake(0, 0, CGFloat((width-2) * 32), CGFloat(height * 32)))
        let miniMap = MiniMapRender(frame:CGRectMake(10, 20, view.bounds.size.width / 4 , view.bounds.size.height - 20))
        var battleField: UIScrollView!
        // the size of viewport is the 3/4 of the screen - 1/4 for the side bar panel.
        battleField = UIScrollView(frame: CGRectMake(view.bounds.size.width / 4, 0, view.bounds.size.width * 3 / 4, view.bounds.size.height))
        battleField.contentSize = theMap.bounds.size
        battleField.backgroundColor = UIColor.blackColor()
        battleField.scrollRectToVisible(CGRect(x: 2500, y: 1600, width: battleField.frame.width, height: battleField.frame.height), animated: true)
        battleField.addSubview(theMap)
        view.addSubview(battleField)
        
        
        //SIDEPANEL
        var sidePanel: UIView!
        sidePanel = UIView(frame: CGRectMake(0, 0, view.bounds.size.width / 4, view.bounds.size.height))
        sidePanel.backgroundColor = UIColor.blackColor()
        sidePanel.addSubview(miniMap)
        view.addSubview(sidePanel)
        
        
        //GESTURES
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: "tappedView:")
        battleField.addGestureRecognizer(tapRec)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tappedView(recognizer:UITapGestureRecognizer) {
        let sound = AVAudioPlayerPool.returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd("thunk.wav", subdir: "misc")
        sound?.prepareToPlay()
        sound?.play()
    }
    
}





