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
        //
        let fullWidth = view.bounds.size.width
        let fullHeight = view.bounds.size.height
        
        a.RetrieveFromDat()
        view.backgroundColor = UIColor.blackColor()
        let (_, width, height ) = MapRender().readMap()
        let theMap = MapRender(frame: CGRectMake(0, 0, CGFloat((width-2) * 32), CGFloat(height * 32)))
        let miniMap = MiniMapRender(frame:CGRectMake(1, fullHeight / 20, fullWidth / 4 , fullHeight / 3))
        var battleField: UIScrollView!
        // the size of viewport is the 3/4 of the screen - 1/4 for the side bar panel.
        battleField = UIScrollView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight))
        battleField.contentSize = theMap.bounds.size
        battleField.backgroundColor = UIColor.blackColor()
        battleField.scrollRectToVisible(CGRect(x: 2500, y: 1600, width: battleField.frame.width, height: battleField.frame.height), animated: true)
        battleField.addSubview(theMap)
        view.addSubview(battleField)
        
        let miniHeight = miniMap.bounds.size.height
        let miniWidth = miniMap.bounds.size.width
        
        //SIDEPANEL
        var sidePanel: UIView!
        sidePanel = UIView(frame: CGRectMake(0, 0, (fullWidth / 4) + 2, fullHeight))
        sidePanel.backgroundColor = UIColor.blackColor()
        sidePanel.addSubview(miniMap)
        view.addSubview(sidePanel)
        
        //MENUPANEL by Javi
        var menuPanel: UIView!
        menuPanel = UIView(frame: CGRectMake(0, 0, fullWidth, fullHeight / 20))
        menuPanel.backgroundColor = UIColor.blueColor()
        //sidePanel.addSubview(miniMap)
        view.addSubview(menuPanel)
        
        //DESCRIPTIONPANEL by Javi
        var descPanel: UIView!
        descPanel = UIView(frame: CGRectMake(1, miniHeight + 12, miniWidth, miniHeight/1.1))
        descPanel.backgroundColor = UIColor.redColor()
        //sidePanel.addSubview(miniMap)
        view.addSubview(descPanel)
        
        //ACTIONPANEL by Javi
        var actPanel: UIView!
        actPanel = UIView(frame: CGRectMake(1, (miniHeight * 2) + 3, miniWidth, miniHeight/1.1))
        actPanel.backgroundColor = UIColor.yellowColor()
        //sidePanel.addSubview(miniMap)
        view.addSubview(actPanel)
        
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





