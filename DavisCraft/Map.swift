//
//  Map.swift
//  DavisCraft
//
//  Created by Andrew Tran on 11/1/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation
import SpriteKit

class Map: SKNode {
    var camera = SKNode()
    
    override init() {
        super.init()
        addChild(camera)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func centerOnCamera() {
        let cameraPositionInScene = scene!.convertPoint(camera.position, fromNode: self)
        position = CGPointMake(position.x - cameraPositionInScene.x, position.y - cameraPositionInScene.y)
    }
}