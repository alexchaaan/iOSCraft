//
//  DescPanelRender.swift
//  DavisCraft
//
//  Created by Kim Nguyen on 11/8/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import SpriteKit
import UIKit
import Foundation
//    func drawLabel(xDir: CGFloat, yDir: CGFloat, width: CGFloat, height: CGFloat, text: String, size: CGFloat){

let ICON_X: CGFloat = 10
let ICON_Y: CGFloat = 10
let HPBAR_Y: CGFloat = 50
let HP_X: CGFloat = 10
let HP_Y: CGFloat = 60
let NAME_X: CGFloat = 55
let NAME_Y: CGFloat = 15
let NAME_FONT: CGFloat = 15
let DESC_FONT: CGFloat = 8
let FIRST_DESC_Y: CGFloat = 45
let DESC_PLUS: CGFloat = 10

class DescLabelRender: IconsRender {
    
    func createBorder(){
        let border = UIImageView(image: UIImage(named: "Border.png")) // Whatever image you want
        self.addSubview(border)
        border.frame = CGRectMake(0, 0, 170, 110)
        self.sendSubviewToBack(border)
    }
    
    func labelPrint(curObject: SKNode){
        switch curObject{
        case is Peasant:
            print("got in peasant case")
            removeCurPanel()
            createBorder()
            drawIcon(2, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 30
            if let peasant = curObject as? Peasant {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(peasant.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Peasant", size: 15)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y, width: 100, height: DESC_PLUS, text: "Armor: \(peasant.armor)", size: DESC_FONT) // Armor
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + DESC_PLUS, width: 100, height: DESC_PLUS, text: "Damage: \(peasant.basicDamage)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 2 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Range: \(peasant.attackRange)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 3 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Sight: \(peasant.sight)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 4 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Speed: \(peasant.unitSpeed)", size: DESC_FONT)
            }
        case is Footman:
            removeCurPanel()
            createBorder()
            drawIcon(4, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 60
            if let footman = curObject as? Footman {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(footman.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Archer", size: 15)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y, width: 100, height: DESC_PLUS, text: "Armor: \(footman.armor)", size: DESC_FONT) // Armor
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + DESC_PLUS, width: 100, height: DESC_PLUS, text: "Damage: \(footman.basicDamage)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 2 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Range: \(footman.attackRange)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 3 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Sight: \(footman.sight)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 4 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Speed: \(footman.unitSpeed)", size: DESC_FONT)
            }
        case is Ranger:
            removeCurPanel()
            createBorder()
            drawIcon(8, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 60
            if let ranger = curObject as? Ranger {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(ranger.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Archer", size: 15)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y, width: 100, height: DESC_PLUS, text: "Armor: \(ranger.armor)", size: DESC_FONT) // Armor
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + DESC_PLUS, width: 100, height: DESC_PLUS, text: "Damage: \(ranger.basicDamage)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 2 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Range: \(ranger.attackRange)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 3 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Sight: \(ranger.sight)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 4 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Speed: \(ranger.unitSpeed)", size: DESC_FONT)
            }
        case is Archer:
            removeCurPanel()
            createBorder()
            drawIcon(6, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 40
            if let archer = curObject as? Archer {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(archer.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Archer", size: 15)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y, width: 100, height: DESC_PLUS, text: "Armor: \(archer.armor)", size: DESC_FONT) // Armor
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + DESC_PLUS, width: 100, height: DESC_PLUS, text: "Damage: \(archer.basicDamage)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 2 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Range: \(archer.attackRange)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 3 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Sight: \(archer.sight)", size: DESC_FONT)
                drawLabel(NAME_X, yDir: FIRST_DESC_Y + 4 * DESC_PLUS, width: 100, height: DESC_PLUS, text: "Speed: \(archer.unitSpeed)", size: DESC_FONT)
            }
        case is TownHall:
            removeCurPanel()
            createBorder()
            drawIcon(42, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 1200
            if let townHall = curObject as? TownHall {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(townHall.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Town Hall", size: 15)
            }
        case is GoldMine:
            removeCurPanel()
            createBorder()
            drawIcon(76, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 25500
            if let goldMine = curObject as? GoldMine {
                drawLabel(HP_X, yDir: HP_Y, width: 55, height: 10, text: "\(goldMine.HP)/\(MAX_HP)", size: 6)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Gold Mine", size: 15)
            }
        case is Barracks:
            removeCurPanel()
            createBorder()
            drawIcon(44, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 800
            if let barracks = curObject as? Barracks {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(barracks.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Barracks", size: 15)
            }
        case is BlackSmith:
            removeCurPanel()
            createBorder()
            drawIcon(48, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 775
            if let blackSmith = curObject as? BlackSmith {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(blackSmith.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Blacksmith", size: 15)
            }
        case is Castle:
            removeCurPanel()
            createBorder()
            drawIcon(70, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 1600
            if let castle = curObject as? Castle {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(castle.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Castle", size: 15)
            }
        case is Farm:
            removeCurPanel()
            createBorder()
            drawIcon(40, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 400
            if let farm = curObject as? Farm {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(farm.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Farm", size: 15)
            }
        case is GuardTower:
            removeCurPanel()
            createBorder()
            drawIcon(4, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 150
            if let guardTower = curObject as? GuardTower {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(guardTower.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Guard Tower", size: 15)
            }
        case is Keep:
            removeCurPanel()
            createBorder()
            drawIcon(68, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 1400
            if let keep = curObject as? Keep {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(keep.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Keep", size: 15)
            }
        case is LumberMill:
            removeCurPanel()
            createBorder()
            drawIcon(46, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 600
            if let lumberMill = curObject as? LumberMill {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(lumberMill.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Lumber Mill", size: 15)
            }
        case is ScoutTower:
            removeCurPanel()
            createBorder()
            drawIcon(62, xDir: ICON_X, yDir: ICON_Y)
            drawHPBar(HP_X, yDir: HPBAR_Y, width: 45, height: 7)
            let MAX_HP = 100
            if let scoutTower = curObject as? ScoutTower {
                drawLabel(HP_X, yDir: HP_Y, width: 45, height: 10, text: "\(scoutTower.HP)/\(MAX_HP)", size: 8)
                drawLabel(NAME_X, yDir: NAME_Y, width: 80, height: 15, text: "Scout Tower", size: 15)
            }
        default:
            removeCurPanel()
            createBorder()
            drawHPBar(0, yDir: 0, width: 0, height: 0)
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
