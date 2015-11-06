//
//  Tile.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/12/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit
import SpriteKit

var goldValue: Int = 10000
var lumberValue: Int = 10000

class TileController: UIView{
    
    var selected: Bool?
    let actionPanel = IconsRender()
    var menuPanel = IconsRender()
    
    /*override func*/func viewDidLoad() {
        //        super.viewDidLoad()
        
        //MAP
        let a = MapRenderer()
        //
        let fullWidth = self.bounds.size.width
        let fullHeight = self.bounds.size.height
        
        a.RetrieveFromDat()
        self.backgroundColor = UIColor.clearColor()
        //let (_, width, height ) = MapRender().readMap()
        //let theMap = MapRender(frame: CGRectMake(0, 0, CGFloat((width-2) * 32), CGFloat(height * 32)))
        //let theMap = GameScene().map
        let miniMap = MiniMapRender(frame:CGRectMake(5, fullHeight / 20 + 25, fullWidth / 4 - 7, fullHeight / 3 - 25))
        //        var battleField: UIScrollView!
        //        // the size of viewport is the 3/4 of the screen - 1/4 for the side bar panel.
        //        battleField = UIScrollView(frame: CGRectMake(fullWidth / 4, fullHeight / 20, fullWidth * 3 / 4, fullHeight))
        //        battleField.contentSize = theMap.bounds.size
        //        battleField.backgroundColor = UIColor.clearColor()
        //        battleField.scrollRectToVisible(CGRect(x: 2500, y: 1600, width: battleField.frame.width, height: battleField.frame.height), animated: true)
        //        battleField.addSubview(theMap)
        //        view.addSubview(battleField)
        
        let miniHeight = miniMap.bounds.size.height
        let miniWidth = miniMap.bounds.size.width
        
        //SIDEPANEL
        
        var sidePanel: UIView!
        sidePanel = UIView(frame: CGRectMake(0, 0, (fullWidth / 4) + 2, fullHeight))
        sidePanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        sidePanel.addSubview(miniMap)
        self.addSubview(sidePanel)
        
        //        var goldValue: Int = 10000
        //        var lumberValue: Int = 10000
        
        //MENUPANEL by Javi
        //        let menuPanel = IconsRender()
        menuPanel.frame = CGRectMake(0, 0, fullWidth, fullHeight / 20)
        menuPanel.drawMIcon(2, xDir: 180 , yDir: 2)
        menuPanel.drawMIcon(3, xDir: 330, yDir: 2)
        menuPanel.drawMIcon(4, xDir: 480, yDir: 2)
        menuPanel.drawGoldLabel(183, yDir: 5, width: 50, height: 10, text: "\(goldValue)", size: 8)
        menuPanel.drawWoodLabel(333, yDir: 5, width: 50, height: 10, text: "\(lumberValue)", size: 8)
        let menuB = UIImageView(image: UIImage(named: "MenuButton.png"))
        // let  buttonImg = UIImageView(image: UIImage(named: "MenuButton.png"))
        // let menuB = UIButton(frame: CGRect(x: sidePanel.bounds.size.width / 4 - 2, y: 1, width: buttonImg.bounds.size.width, height: buttonImg.bounds.size.height))
        // menuB.imageView!.image = buttonImg.image
        //           let humanMove = UIImageView(image: UIImage(CGImage: iDictionary![iNames[85]]!))
        //        self.addSubview(button)
        menuB.frame = CGRectMake(sidePanel.bounds.size.width / 4 - 2, 1, menuB.bounds.size.width, menuB.bounds.size.height)
        menuPanel.addSubview(menuB)
        menuPanel.backgroundColor = UIColor(patternImage: UIImage(named: "Texture.png")!)
        self.addSubview(menuPanel)
        
        //strings for description panel, these are defaults
        var armor: Int = 0
        var dmgLow: Int = 1
        var dmgHigh: Int = 5
        var range: Int = 1
        var sight: Int = 4
        var speed: Int = 10
        var peasantLabel: String = "Peasant"
        var armorLabel: String = "Armor: \(armor)"
        var dmgLabel: String = "Damage: \(dmgLow)-\(dmgHigh)"
        var rangeLabel: String = "Range: \(range)"
        var sightLabel: String = "Sight: \(sight)"
        var speedLabel: String = "Speed: \(speed)"
        
        //DESCRIPTIONPANEL by Javi
        let descPanel = IconsRender()
        descPanel.frame = CGRectMake(1, miniHeight * 1.5, miniWidth, miniHeight/1.1)
        descPanel.drawIcon(2, xDir: 5, yDir: 5)
        let hpBar: UIImageView = UIImageView(frame: CGRectMake(5, 45, 45, 7))
        hpBar.backgroundColor = UIColor.greenColor()
        descPanel.addSubview(hpBar)
        descPanel.drawLabel(55, yDir: 5, width: 80, height: 15, text: peasantLabel, size: 15)
        descPanel.drawLabel(55, yDir: 45, width: 100, height: 10, text: armorLabel, size: 8)
        descPanel.drawLabel(55, yDir: 55, width: 100, height: 10, text: dmgLabel, size: 8)
        descPanel.drawLabel(55, yDir: 65, width: 100, height: 10, text: rangeLabel, size: 8)
        descPanel.drawLabel(55, yDir: 75, width: 100, height: 10, text: sightLabel, size: 8)
        descPanel.drawLabel(55, yDir: 85, width: 100, height: 10, text: speedLabel, size: 8)
        let border = UIImageView(image: UIImage(named: "Border.png")) // Whatever image you want
        let border1 = border
        descPanel.addSubview(border)
        border.frame = CGRectMake(3, 3, 20, 35)
        descPanel.sendSubviewToBack(border)
        self.addSubview(descPanel)
        
        
        actionPanel.drawPeasant()
        actionPanel.frame = CGRectMake(1, (miniHeight * 2.5), miniWidth/0.95, miniHeight / 0.8)
        border1.frame = CGRectMake(0, 0, actionPanel.bounds.size.width, actionPanel.bounds.size.height)
        actionPanel.addSubview(border1)
        actionPanel.sendSubviewToBack(border1)
        //view.addSubview(actionPanel)
        
        
        //GESTURES
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: "tappedView:")
        //battleField.addGestureRecognizer(tapRec)
        self.selected = false
        
        //        view.addSubview(b)
        //        view.bringSubviewToFront(b)
    }
    
    
    
    
    
    //    func tappedView(recognizer:UITapGestureRecognizer) {
    //        let sound = AVAudioPlayerPool.returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd("thunk.wav", subdir: "misc")
    //        sound?.prepareToPlay()
    //        sound?.play()
    //        if selected == false{
    //            self.addSubview(actionPanel)
    //            self.selected = true
    //        }
    //        else{
    //            actionPanel.removeFromSuperview()
    //            self.selected = false
    //        }
    //        
    //    }
    
    
}





