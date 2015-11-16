////
////  DescPanelRender.swift
////  DavisCraft
////
////  Created by Kim Nguyen on 11/8/15.
////  Copyright © 2015 UCDClassNitta. All rights reserved.
////
//
import SpriteKit
import UIKit
import Foundation


class ActionPanelRender: IconsRender {
    
    let  size = 41.5
    var selectedAsset : SKNode!
    var Button1 = UIButton()
    var Button2 = UIButton()
    var Button3 = UIButton()
    var Button4 = UIButton()
    var Button5 = UIButton()
    var Button6 = UIButton()
    var Button7 = UIButton() //for walls when we implement them as something peasants can make
    var Button8 = UIButton()
    
    func createBorder(){
        let border = UIImageView(image: UIImage(named: "Border.png")) // Whatever image you want
        self.addSubview(border)
        border.frame = CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height - 20)
        self.sendSubviewToBack(border)
        
    }

    func labelPrint(curObject: SKNode){
        selectedAsset = curObject
        
        switch curObject{
        case is Peasant:
            removeCurPanel()
            createBorder()
            if let peasant = curObject as? Peasant {
                let (iDictionary, iNames) = readIcons()
                
                let humanMove = UIButton()
                humanMove.setImage(UIImage(CGImage: iDictionary![iNames[85]]!), forState: UIControlState.Normal)
                let repair = UIButton()
                repair.setImage(UIImage(CGImage: iDictionary![iNames[87]]!), forState: UIControlState.Normal)
                let mine = UIButton()
                mine.setImage(UIImage(CGImage: iDictionary![iNames[88]]!), forState: UIControlState.Normal)
                let buildSimple = UIButton()
                buildSimple.setImage(UIImage(CGImage: iDictionary![iNames[89]]!), forState: UIControlState.Normal)
                let humanWeapon1 = UIButton()
                humanWeapon1.setImage(UIImage(CGImage: iDictionary![iNames[118]]!), forState: UIControlState.Normal)
                let humanArmor1 = UIButton()
                humanArmor1.setImage(UIImage(CGImage: iDictionary!["human-armor-1"]!), forState: UIControlState.Normal)
                
                humanMove.frame = CGRect(x: 13, y: 15, width: size, height: size)
                repair.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                mine.frame = CGRect(x: 24 + size * 2, y: 15, width: size, height: size)
                buildSimple.frame = CGRect(x: 13, y: 25 + size, width: size, height: size)
                humanWeapon1.frame = CGRect(x: 18 + size, y: 25 + size, width: size, height: size)
                humanArmor1.frame = CGRect(x: 24 + size * 2, y: 25 + size, width: size, height: size)
                
                humanMove.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
                humanWeapon1.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
                repair.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
                mine.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
                buildSimple.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
                buildSimple.addTarget(self, action: "createBuildings:", forControlEvents: UIControlEvents.TouchUpInside)
                
                Button1 = humanMove
                Button2 = repair
                Button3 = mine
                Button4 = buildSimple
                Button5 = humanWeapon1
                Button6 = humanArmor1
                
                self.addSubview(Button1)
                self.addSubview(Button2)
                self.addSubview(Button3)
                self.addSubview(Button4)
                self.addSubview(Button5)
                self.addSubview(Button6)
                
            }
        case is Footman:
            removeCurPanel()
            createBorder()
            if let footman = curObject as? Footman {
                let (iDictionary, iNames) = readIcons()
                
                let humanMove = UIButton()
                humanMove.setImage(UIImage(CGImage: iDictionary![iNames[85]]!), forState: UIControlState.Normal)
                let humanPatrol = UIButton()
                humanPatrol.setImage(UIImage(CGImage: iDictionary!["human-patrol"]!), forState: UIControlState.Normal)
                let humanWeapon1 = UIButton()
                humanWeapon1.setImage(UIImage(CGImage: iDictionary![iNames[118]]!), forState: UIControlState.Normal)
                let humanArmor1 = UIButton()
                humanArmor1.setImage(UIImage(CGImage: iDictionary!["human-armor-1"]!), forState: UIControlState.Normal)
                
                humanMove.frame = CGRect(x: 13, y: 15, width: size, height: size)
                humanPatrol.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                humanWeapon1.frame = CGRect(x: 18 + size, y: 25 + size, width: size, height: size)
                humanArmor1.frame = CGRect(x: 24 + size * 2, y: 25 + size, width: size, height: size)
                
                Button1 = humanMove
                Button2 = humanPatrol
                Button3 = humanWeapon1
                Button4 = humanArmor1
                
                self.addSubview(Button1)
                self.addSubview(Button2)
                self.addSubview(Button3)
                self.addSubview(Button4)
            }
        case is Ranger:
            removeCurPanel()
            createBorder()
            if let ranger = curObject as? Ranger {
                let (iDictionary, iNames) = readIcons()
                let humanMove = UIButton()
                humanMove.setImage(UIImage(CGImage: iDictionary![iNames[85]]!), forState: UIControlState.Normal)
                let humanPatrol = UIButton()
                humanPatrol.setImage(UIImage(CGImage: iDictionary!["human-patrol"]!), forState: UIControlState.Normal)
                let humanWeapon1 = UIButton()
                humanWeapon1.setImage(UIImage(CGImage: iDictionary![iNames[118]]!), forState: UIControlState.Normal)
                let humanArmor1 = UIButton()
                humanArmor1.setImage(UIImage(CGImage: iDictionary!["human-armor-1"]!), forState: UIControlState.Normal)
                
                humanMove.frame = CGRect(x: 13, y: 15, width: size, height: size)
                humanPatrol.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                humanWeapon1.frame = CGRect(x: 18 + size, y: 25 + size, width: size, height: size)
                humanArmor1.frame = CGRect(x: 24 + size * 2, y: 25 + size, width: size, height: size)
                
                Button1 = humanMove
                Button2 = humanPatrol
                Button3 = humanWeapon1
                Button4 = humanArmor1
                
                self.addSubview(Button1)
                self.addSubview(Button2)
                self.addSubview(Button3)
                self.addSubview(Button4)            }
        case is Archer:
            removeCurPanel()
            createBorder()
            if let archer = curObject as? Archer {
                let (iDictionary, iNames) = readIcons()
                let humanMove = UIButton()
                humanMove.setImage(UIImage(CGImage: iDictionary![iNames[85]]!), forState: UIControlState.Normal)
                let humanPatrol = UIButton()
                humanPatrol.setImage(UIImage(CGImage: iDictionary!["human-patrol"]!), forState: UIControlState.Normal)
                let humanWeapon1 = UIButton()
                humanWeapon1.setImage(UIImage(CGImage: iDictionary![iNames[118]]!), forState: UIControlState.Normal)
                let humanArmor1 = UIButton()
                humanArmor1.setImage(UIImage(CGImage: iDictionary!["human-stand-ground"]!), forState: UIControlState.Normal)
                
                humanMove.frame = CGRect(x: 13, y: 15, width: size, height: size)
                humanPatrol.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                humanWeapon1.frame = CGRect(x: 18 + size, y: 25 + size, width: size, height: size)
                humanArmor1.frame = CGRect(x: 24 + size * 2, y: 25 + size, width: size, height: size)
                
                Button1 = humanMove
                Button2 = humanPatrol
                Button3 = humanWeapon1
                Button4 = humanArmor1
                
                self.addSubview(Button1)
                self.addSubview(Button2)
                self.addSubview(Button3)
                self.addSubview(Button4)
            }
        case is TownHall:
            removeCurPanel()
            createBorder()
            if let townHall = curObject as? TownHall {
                let (iDictionary, iNames) = readIcons()
                
                let BuildPeasant = UIButton()
                BuildPeasant.setImage(UIImage(CGImage: iDictionary![iNames[2]]!), forState: UIControlState.Normal)
                let BuildKeep = UIButton()
                BuildKeep.setImage(UIImage(CGImage: iDictionary![iNames[43]]!), forState: UIControlState.Normal)
                
                BuildPeasant.frame = CGRect(x: 13, y: 15, width: size, height: size)
                BuildKeep.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                
                Button1 = BuildPeasant
                Button2 = BuildKeep
                
                self.addSubview(Button1)
                self.addSubview(Button2)}
        case is GoldMine:
            removeCurPanel()
            createBorder()
            if let goldMine = curObject as? GoldMine {
            }
        case is Barracks:
            removeCurPanel()
            createBorder()
            if let barracks = curObject as? Barracks {
                let (iDictionary, iNames) = readIcons()
                
                let BuildFootman = UIButton()
                BuildFootman.setImage(UIImage(CGImage: iDictionary!["footman"]!), forState: UIControlState.Normal)
                let BuildArcher = UIButton()
                BuildArcher.setImage(UIImage(CGImage: iDictionary!["archer"]!), forState: UIControlState.Normal)
                
                BuildFootman.frame = CGRect(x: 13, y: 15, width: size, height: size)
                BuildArcher.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                
                Button1 = BuildFootman
                Button2 = BuildArcher
                
                self.addSubview(Button1)
                self.addSubview(Button2)
            }
        case is BlackSmith:
            removeCurPanel()
            createBorder()
            if let blackSmith = curObject as? BlackSmith {
                let (iDictionary, iNames) = readIcons()
                
                let WeaponUpgrade2 = UIButton()
                WeaponUpgrade2.setImage(UIImage(CGImage: iDictionary!["human-weapon-2"]!), forState: UIControlState.Normal)
                let ArmorUpgrade2 = UIButton()
                ArmorUpgrade2.setImage(UIImage(CGImage: iDictionary!["human-armor-2"]!), forState: UIControlState.Normal)
                
                WeaponUpgrade2.frame = CGRect(x: 13, y: 15, width: size, height: size)
                ArmorUpgrade2.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                
                Button1 = WeaponUpgrade2
                Button2 = ArmorUpgrade2
                
                self.addSubview(Button1)
                self.addSubview(Button2)}
        case is Castle:
            removeCurPanel()
            createBorder()
            if let castle = curObject as? Castle {
                let (iDictionary, iNames) = readIcons()
                
                let BuildPeasant = UIButton()
                BuildPeasant.setImage(UIImage(CGImage: iDictionary![iNames[2]]!), forState: UIControlState.Normal)
                
                BuildPeasant.frame = CGRect(x: 13, y: 15, width: size, height: size)
                
                Button1 = BuildPeasant
                
                self.addSubview(Button1)}
        case is Farm:
            removeCurPanel()
            createBorder()
            if let farm = curObject as? Farm {
            }
        case is GuardTower:
            removeCurPanel()
            createBorder()
            if let guardTower = curObject as? GuardTower {
            }
        case is Keep:
            removeCurPanel()
            createBorder()
            if let keep = curObject as? Keep {
                let (iDictionary, iNames) = readIcons()
                
                let BuildPeasant = UIButton()
                BuildPeasant.setImage(UIImage(CGImage: iDictionary![iNames[2]]!), forState: UIControlState.Normal)
                let BuildCastle = UIButton()
                BuildCastle.setImage(UIImage(CGImage: iDictionary!["castle"]!), forState: UIControlState.Normal)
                
                BuildPeasant.frame = CGRect(x: 13, y: 15, width: size, height: size)
                BuildCastle.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                
                Button1 = BuildPeasant
                Button2 = BuildCastle
                
                self.addSubview(Button1)
                self.addSubview(Button2)}
        case is LumberMill: //check images see if they are correct
            removeCurPanel()
            createBorder()
            if let lumberMill = curObject as? LumberMill {
                let (iDictionary, iNames) = readIcons()
                
                let ArrowUpgrade2 = UIButton()
                ArrowUpgrade2.setImage(UIImage(CGImage: iDictionary!["human-arrow-2"]!), forState: UIControlState.Normal)
                let BuildRanger = UIButton()
                BuildRanger.setImage(UIImage(CGImage: iDictionary!["ranger"]!), forState: UIControlState.Normal)
                
                ArrowUpgrade2.frame = CGRect(x: 13, y: 15, width: size, height: size)
                BuildRanger.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                
                Button1 = ArrowUpgrade2
                Button2 = BuildRanger
                
                self.addSubview(Button1)
                self.addSubview(Button2)
            }
        case is ScoutTower:
            removeCurPanel()
            createBorder()
            if let scoutTower = curObject as? ScoutTower {
                let (iDictionary, iNames) = readIcons()
                
                let guardTower = UIButton()
                guardTower.setImage(UIImage(CGImage: iDictionary!["human-guard-tower"]!), forState: UIControlState.Normal)
                let cannonTower = UIButton()
                cannonTower.setImage(UIImage(CGImage: iDictionary!["human-cannon-tower"]!), forState: UIControlState.Normal)
                
                guardTower.frame = CGRect(x: 13, y: 15, width: size, height: size)
                cannonTower.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
                
                Button1 = guardTower
                Button2 = cannonTower
                
                self.addSubview(Button1)
                self.addSubview(Button2)}
        default:
            removeCurPanel()
            createBorder()
            drawHPBar(0, yDir: 0, width: 0, height: 0)
        }//end of switch
    }//end of functio
    
    
    func cancelMenu(sender: UIButton!){ //presents the cancelMenu screen
        //curObject: SKNode
        let (iDictionary, iNames) = readIcons()
        removeCurPanel()
        createBorder()
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(CGImage: iDictionary!["cancel"]!), forState: UIControlState.Normal)
        cancelButton.frame = CGRect(x: 30 + size * 2, y: 25 + size, width: size / 2, height: size / 2)
        cancelButton.setBackgroundImage(UIImage(named: "Border.png"), forState: .Normal)
        cancelButton.addTarget(self, action: "returnBack:", forControlEvents: .TouchUpInside)
        Button8 = cancelButton
        self.addSubview(Button8)
    }
    
    func returnBack(sender:UIButton!){ //gets called from cancelMenu press
        labelPrint(selectedAsset)
    }
    
    func createBuildings(sender:UIButton!){ //walls will need to be here as well, so there should be eight buttons
        let (iDictionary, iNames) = readIcons()
////        removeCurPanel()
////        createBorder()
//        BuildSimple
//        BuildTownHall
//        BuildFarm
//        BuildBarracks
//        BuildLumberMill
//        BuildScoutTower
//        BuildBlacksmith
//        BuildWall
        
        let BuildTownHall = UIButton()
        BuildTownHall.setImage(UIImage(CGImage: iDictionary!["town-hall"]!), forState: UIControlState.Normal)
        let BuildFarm = UIButton()
        BuildFarm.setImage(UIImage(CGImage: iDictionary!["chicken-farm"]!), forState: UIControlState.Normal)
        let BuildBarracks = UIButton()
        BuildBarracks.setImage(UIImage(CGImage: iDictionary!["human-barracks"]!), forState: UIControlState.Normal)
        let BuildLumberMill = UIButton()
        BuildLumberMill.setImage(UIImage(CGImage: iDictionary!["human-lumber-mill"]!), forState: UIControlState.Normal)
        let BuildScoutTower = UIButton()
        BuildScoutTower.setImage(UIImage(CGImage: iDictionary!["scout-tower"]!), forState: UIControlState.Normal)
        let BuildBlacksmith = UIButton()
        BuildBlacksmith.setImage(UIImage(CGImage: iDictionary!["human-blacksmith"]!), forState: UIControlState.Normal)
        
        BuildTownHall.frame = CGRect(x: 13, y: 15, width: size, height: size)
        BuildFarm.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
        BuildBarracks.frame = CGRect(x: 24 + size * 2, y: 15, width: size, height: size)
        BuildLumberMill.frame = CGRect(x: 13, y: 25 + size, width: size, height: size)
        BuildScoutTower.frame = CGRect(x: 18 + size, y: 25 + size, width: size, height: size)
        BuildBlacksmith.frame = CGRect(x: 24 + size * 2, y: 25 + size, width: size, height: size)
        
        BuildTownHall.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        BuildFarm.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        BuildBarracks.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        BuildLumberMill.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        BuildScoutTower.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        BuildBlacksmith.addTarget(self, action: "cancelMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        
        Button1 = BuildTownHall
        Button2 = BuildFarm
        Button3 = BuildBarracks
        Button4 = BuildLumberMill
        Button5 = BuildScoutTower
        Button6 = BuildBlacksmith
        
        self.addSubview(Button1)
        self.addSubview(Button2)
        self.addSubview(Button3)
        self.addSubview(Button4)
        self.addSubview(Button5)
        self.addSubview(Button6)

    }
    
    
}





