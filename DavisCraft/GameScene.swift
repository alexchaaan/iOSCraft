//
//  GameScene.swift
//  DavisCraft
//
//  Created by Charlie on 10/2/15.
//  Copyright (c) 2015 UCDClassNitta. All rights reserved.
//
import UIKit
import SpriteKit

let TILE_WIDTH = CGFloat(32)
let TILE_HEIGHT = CGFloat(32)

class GameScene: SKScene {
    var didSelect: Bool?
    let map = Map() //SKNode
    var lastTouchPosition = CGPointZero
    var selected : SKNode!
    var peasantImages : [SKTexture] = []
    var width = Int()
    var height = Int()
    let tile = Tile()
    let townHall = TownHall()
    var timer: NSTimer?
    var goldValue: Int = 10000
    var lumberValue: Int = 10000
    
//use contact to do the trees and stuff
    struct PhysicsCategory {
        static let None : UInt32 = 0
        static let Peasant : UInt32 = 1
        static let Terrain : UInt32 = 2
    }
    
    override func didMoveToView(view: SKView) {
        addChild(map)
        let mapRender = MapRender()
        (_, width, height ) = mapRender.readMap()
        mapRender.drawRect(map)
        tile.viewDidLoad()
        townHall.constructor()
        townHall.createTower(map)
//        map.scene?.physicsWorld.gravity = CGVectorMake(0, 0)
//        let sceneBody = SKPhysicsBody(edgeLoopFromRect: map.frame)
//        sceneBody.friction = 0
//        map.scene?.physicsBody = sceneBody
        
//        view.bounds.size.width = CGFloat(width * 32)
//        view.bounds.size.height = CGFloat(height * 32)
//        print(view.bounds.size)
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: "tappedView:")
        self.view!.addGestureRecognizer(tapRec)
        let doubleTapRec = UITapGestureRecognizer()
        doubleTapRec.numberOfTouchesRequired = 2
        doubleTapRec.addTarget(self, action: "doubleTap:")
        self.view!.addGestureRecognizer(doubleTapRec)
        self.setTimer()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        lastTouchPosition = touches.first!.locationInNode(self)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let newTouchPosition = touches.first!.locationInNode(self)
        let touchOffsetVector = CGPointMake(newTouchPosition.x - lastTouchPosition.x, (newTouchPosition.y - lastTouchPosition.y) )
        let mapCameraPositionInScene = convertPoint(map.camera.position, toNode: self)
        let cameraPos = CGPointMake(mapCameraPositionInScene.x - touchOffsetVector.x, mapCameraPositionInScene.y - touchOffsetVector.y)
        let rightBound = convertPoint(CGPointMake(CGFloat(width * 32), CGFloat(0)), toNode: self)
        let leftBound = convertPoint(CGPointZero, toNode: self)
        //let topBound = convertPoint(CGPointMake(CGFloat(height * 32), CGFloat(0)), toNode: self)
//        let topBound = convertPoint(CGPointZero, toNode: self)
//        if cameraPos.x < rightBound.x && cameraPos.x > leftBound.x{
            map.camera.position = cameraPos
//        }
        
        
       // map.camera.position = CGPointMake(mapCameraPositionInScene.x - touchOffsetVector.x, mapCameraPositionInScene.y - touchOffsetVector.y)
        lastTouchPosition = newTouchPosition
//        anchorPoint = CGPointZero
//        map.camera.position = CGPointMake(min(max(mapCameraPositionInScene.x - touchOffsetVector.x, 0), CGFloat(width) * TILE_WIDTH - frame.size.width),
//            min(max(mapCameraPositionInScene.y - touchOffsetVector.y, 0), CGFloat(height) * TILE_HEIGHT - frame.size.height))
        
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func didFinishUpdate() {
        map.centerOnCamera()
    }
    
    
    func setPeasantImages(startIndex: Int, endIndex: Int){
        if endIndex < startIndex{
            for i in endIndex...startIndex{
                //            peasantImages.append(self.texture(i))
                peasantImages += [self.texture(i)]
            }
        }
        else{
            for i in startIndex...endIndex{
                //            peasantImages.append(self.texture(i))
                peasantImages += [self.texture(i)]
            }
        }
    }
    
    func texture(index:Int) -> SKTexture{
        let content = FileManager.returnDatFileContents("Peasant.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        
        var image = UIImage()
        
        image = UIImage(named: "data/png/Peasant.png")!
        
        let h = image.size.height - 1
        let w = image.size.width - 1
        
        let numberOfTiles = Int(contentArray[1]);
        
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        
        let otherImage = UIImage(CGImage: tile!)
        let texture = SKTexture(image: otherImage)
        
        return texture
    }
    func doubleTap(recognizer:UITapGestureRecognizer) {
        self.createPeasant()

            if didSelect == false{
                self.view!.addSubview(tile)
                self.didSelect = true
            }
            else{
                tile.removeFromSuperview()
                self.didSelect = false
            }

    }
    
    func tappedView(recognizer:UITapGestureRecognizer) {
        let viewTouchLocation = recognizer.locationInView((self.view))
        let sceneTouchLocation = self.convertPointFromView(viewTouchLocation)
        let touchedNode = self.nodeAtPoint(sceneTouchLocation)
        if(touchedNode.name != nil) {
            if(selected != nil) {
                if(selected.name == "peasant") {
//                    if selected.name != "peasant"{
//                        moveSprite(selected.position)
//                    }
                    if touchedNode.name == "goldmine"{
//                        selected = touchedNode
                        self.gatherGold(touchedNode.position)
                    }
                    else{
                        moveSprite(self.selected, touched: self.convertPoint(sceneTouchLocation, toNode: map))
                    }
                    selected = nil
                }

            }
            else {
                selected = nil
            }
        }
        if(touchedNode.name == "peasant") {
            let sound = AVAudioPlayerPool.returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd("thunk.wav", subdir: "misc")
            sound?.prepareToPlay()
            sound?.play()
            selected = touchedNode
        }
        else if touchedNode.name == "townhall"{
            selected = touchedNode
            createPeasant()
        }
//        print(touchedNode.name)
    }
    
    
    func gatherGold(goldMineLocation: CGPoint){
        print("gathering gold")
        let selectedRef = self.selected
        let moveToGoldMine = SKAction.runBlock { () -> Void in
            self.moveSprite(selectedRef, touched: goldMineLocation)
        }
        let delay = SKAction.waitForDuration(2)

        let moveToTownHall = SKAction.runBlock { () -> Void in
            self.moveSprite(selectedRef, touched: self.townHall.location!)
        }
        selected.runAction(SKAction.repeatActionForever(SKAction.sequence([moveToGoldMine, delay, moveToTownHall])))
    }
    
    
    func moveSprite(selectedSprite: SKNode, touched: CGPoint) {
        let location = touched
        let distance                = sqrt(pow((location.x - selectedSprite.position.x), 2.0) + pow((location.y - selectedSprite.position.y), 2.0))    // Formula to keep the speed consistent.
        let moveDuration            = 0.005*distance
        let floatDuration           = NSTimeInterval(moveDuration)
        
        var index = 0
        
        let angle = getAngle(selectedSprite.position, endingPoint: location)
        
        if((22.5 < angle) && (angle <= 67.5)) {
//            print(angle)
            self.setDirection(selectedSprite, index: 167)
        }
        if((67.5 < angle) && (angle <= 112.5)) {    // up
            self.setDirection(selectedSprite, index: 172)
        }
        if((112.5 < angle) && (angle <= 157.5)) {
//            print(angle)
            self.setDirection(selectedSprite, index: 137)
        }
        if((157.5 < angle) && (angle <= 202.5)) {   //left
            self.setDirection(selectedSprite, index: 142)
        }
        if((202.5 < angle) && (angle <= 247.5)) {
            self.setDirection(selectedSprite, index: 147)
        }
        if((247.5 < angle) && (angle <= 292.5)) {   //down
            self.setDirection(selectedSprite, index: 152)
        }
        if((292.5 < angle) && (angle <= 337.5)) {
            self.setDirection(selectedSprite, index: 157)
        }
        if((337.5 < angle) || (angle <= 22.5)) {    //right
            self.setDirection(selectedSprite, index: 162)
        }
        let moveAction = SKAction.moveTo(location, duration: floatDuration)
        let walkingAnimation = SKAction.animateWithTextures(peasantImages, timePerFrame: 0.05, resize: false, restore: true)
        let repeatedWalk = SKAction.repeatActionForever(walkingAnimation)
        selectedSprite.runAction(repeatedWalk, withKey: "animation")
        selectedSprite.runAction(moveAction, completion: { selectedSprite.removeActionForKey("animation")})
        print(selectedSprite.name)
//        if .name == "goldmine"{
//            print("gathering golddfsafa")
//        }
        
    }
    
    
    
    func setDirection(selectedSprite: SKNode, index: Int){
        peasantImages.removeAll()
        let sprite = selectedSprite as! SKSpriteNode
        sprite.texture = self.texture(index)
        self.setPeasantImages(index - 1, endIndex: index - 5)
    }
    
    func getAngle(startingPoint: CGPoint, endingPoint: CGPoint)-> Double{
        //        - (CGFloat) pointPairToBearingDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint
        var originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y) // get origin point to origin by subtracting end from start
        var bearingRadians = atan2(Double(originPoint.y), Double(originPoint.x)) // get bearing in radians
        var bearingDegrees = bearingRadians * (180.0 / M_PI) // convert to degrees
        bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)) // correct discontinuity
        return bearingDegrees
    }
    
    
    
    
    func createPeasant() {
        let content = FileManager.returnDatFileContents("Peasant.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        
        var image = UIImage()
        var index = 152
        
        image = UIImage(named: "data/png/Peasant.png")!
        
        let h = image.size.height
        let w = image.size.width
        
        let numberOfTiles = Int(contentArray[1]);
        
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        
        let peasant = SKSpriteNode(texture: SKTexture(CGImage: tile!))
//        peasant.position = convertPoint(CGPointMake(64, 64), fromNode: map)
        peasant.position = CGPointMake(townHall.location!.x, townHall.location!.y + 75)
        peasant.name = "peasant"
        //peasant.yScale = -1
        peasant.zPosition = 1
//        timer!.fire()
        map.addChild(peasant)
        print("created a new peasant")
        self.view?.bringSubviewToFront((self.view)!)
    }

    
    func setTimer(){
        self.timer = NSTimer(timeInterval: 5, target: self.view!, selector: "loading", userInfo: nil, repeats: false)
    }
    
    func loading(){
        print("loading peasant")
    }
}
