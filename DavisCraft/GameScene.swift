//
//  GameScene.swift
//  DavisCraft
//
//  Created by Charlie on 10/2/15.
//  Copyright (c) 2015 UCDClassNitta. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    let map = Map()
    var lastTouchPosition = CGPointZero
    
    override func didMoveToView(view: SKView) {
        addChild(map)
        let mapRender = MapRender()
        mapRender.drawRect(map)
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        lastTouchPosition = touches.first!.locationInNode(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let newTouchPosition = touches.first!.locationInNode(self)
        let touchOffsetVector = CGPointMake(newTouchPosition.x - lastTouchPosition.x, newTouchPosition.y - lastTouchPosition.y)
        let mapCameraPositionInScene = convertPoint(map.camera.position, toNode: self)
        map.camera.position = CGPointMake(mapCameraPositionInScene.x - touchOffsetVector.x, mapCameraPositionInScene.y - touchOffsetVector.y)
        lastTouchPosition = newTouchPosition
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func didFinishUpdate() {
        map.centerOnCamera()
    }
}
