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
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: (self.texture!.size()))
//        print(self.texture!.size())
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.dynamic = true
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.resting = false
        self.physicsBody?.categoryBitMask = 0b11
        //self.physicsBody?.contactTestBitMask = 0
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.restitution = 0
        self.physicsBody?.density = 0
        self.physicsBody?.mass = 1
    }
}

