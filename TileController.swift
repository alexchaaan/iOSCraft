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
    
    var battleField: UIScrollView!
    var miniMap: MiniMapRender!
    var miniMapFrame: CGRect!
    var sidePanel: UIView!
    
    var battleFieldWidth: CGFloat!
    var battleFieldHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MAP
        let a = MapRenderer()
        //
        let fullWidth = view.bounds.size.width
        let fullHeight = view.bounds.size.height
        
        
        print("fullwidth = \(fullWidth), fullheight = \(fullHeight)")
        
        a.RetrieveFromDat()
        view.backgroundColor = UIColor.blackColor()
        let (_, width, height ) = MapRender().readMap()
        let theMap = MapRender(frame: CGRectMake(0, 0, CGFloat((width-2) * 32), CGFloat(height * 32)))
        
        // the size of viewport is the 3/4 of the screen - 1/4 for the side bar panel.
        battleField = UIScrollView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight))
        battleFieldWidth = battleField.frame.width
        battleFieldHeight = battleField.frame.height
        battleField.contentSize = theMap.bounds.size
        battleField.backgroundColor = UIColor.blackColor()
        battleField.scrollRectToVisible(CGRect(x: 2500, y: 1600, width: battleFieldWidth, height: battleFieldHeight), animated: true)
        battleField.addSubview(theMap)
        view.addSubview(battleField)
        
        //SIDEPANEL
        sidePanel = UIView(frame: CGRectMake(0, 0, (fullWidth / 4) + 2, fullHeight))
        sidePanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        //Add MiniMap
        miniMapFrame = CGRectMake(5, fullHeight / 20 + 25, fullWidth / 4 - 6, fullHeight / 3 - 22)
        miniMap = MiniMapRender(frame: miniMapFrame, x_min: 2500, y_min: 1600, width: battleFieldWidth, height: battleFieldHeight)
        //miniMap.drawViewport(2500, y_min: 1600, width: battleField.frame.width, height: battleField.frame.height)
        sidePanel.addSubview(miniMap)
        view.addSubview(sidePanel)
        
        //MENUPANEL by Javi
        var menuPanel: UIView!
        menuPanel = UIView(frame: CGRectMake(0, 0, fullWidth, fullHeight / 20))
        menuPanel.backgroundColor = UIColor.blueColor()
        //sidePanel.addSubview(miniMap)
        view.addSubview(menuPanel)
        
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
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.locationInView(miniMap)
        if location.x >= 0 && location.y >= 0 && location.x <= miniMap.frame.width && location.y <= miniMap.frame.height {
            let (_, _, ratioX, ratioY) = miniMap.getDimensions()
            battleField.scrollRectToVisible(CGRect(x: location.x * ratioX, y: location.y * ratioY, width: battleFieldWidth, height: battleFieldHeight), animated: true)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.locationInView(miniMap)
        if location.x >= 0 && location.y >= 0 && location.x <= miniMap.frame.width && location.y <= miniMap.frame.height {
            let (_, _, ratioX, ratioY) = miniMap.getDimensions()
            battleField.scrollRectToVisible(CGRect(x: location.x * ratioX, y: location.y * ratioY, width: battleFieldWidth, height: battleFieldHeight), animated: true)
            miniMap.removeFromSuperview()
            miniMap = MiniMapRender(frame: miniMapFrame, x_min: location.x * ratioX - battleFieldWidth / 2, y_min: location.y * ratioY - battleFieldHeight / 2, width: battleFieldWidth, height: battleFieldHeight)
            sidePanel.addSubview(miniMap)
        }
    }
    
}





