//
//  Units.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/5/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class Unit: SKSpriteNode{
    var visualRange: Int?
    var HP: Int?
    var MP: Int?
    var buildTime: Int?
    var goldCost: Int?
    var lumberCost: Int?
    var armor: Int?
    var basicDamage: Int?
    var piercingDamage: Int?
    var baseEffectiveDamage: Int?
    var maxEffectiveDamage: Int?
    var attackRange: Int?
    var moveSpeed: Int?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


