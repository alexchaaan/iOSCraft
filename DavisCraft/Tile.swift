//
//  Tile.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 11/5/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class Tile: SKSpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 0
        self.anchorPoint = CGPointMake(0,1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size, center: CGPointMake((self.texture?.size().width)!/2, -(self.texture?.size().height)!/2))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.dynamic = false
        self.physicsBody?.resting = true
        self.physicsBody?.categoryBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b110
        //self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.collisionBitMask = 0b110
        self.physicsBody?.restitution = 0
        self.physicsBody?.density = 0
        self.physicsBody?.mass = 0
    }
}

