
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

class GameScene: SKScene, SKPhysicsContactDelegate {
    var didSelect: Bool?
    let map = Map() //SKNode
    var lastTouchPosition = CGPointZero
    var selected : SKNode!
    var previouslySelected: SKNode!
    var created : SKSpriteNode!
    var buildMode = false
    var isMoving = false
    var didMove = false
    var peasantImages : [SKTexture] = []
    var width = Int()
    var height = Int()
    let tile = TileController()
    var townHall1 = TownHall(location: CGPointMake(2800, -1800))
    var timer: NSTimer?
    var goldValue: Int = 10000
    var lumberValue: Int = 10000
    var mining = false
    var cutting = false
    var lightOn = false
    
    

//use contact to do the trees and stuff

    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        anchorPoint = CGPointMake(0,1)
        addChild(map)
        let mapRender = MapRender()
        (_, width, height ) = mapRender.readMap()
        mapRender.drawRect(map)
        //tile.viewDidLoad()
        map.addChild(townHall1)
        self.physicsWorld.gravity = CGVectorMake(0,0)
        self.physicsWorld.contactDelegate = self
//        map.scene?.physicsWorld.gravity = CGVectorMake(0, 0)
//        let sceneBody = SKPhysicsBody(edgeLoopFromRect: map.frame)
//        sceneBody.friction = 0
//        map.scene?.physicsBody = sceneBody
        
//        view.bounds.size.width = CGFloat(width * 32)
//        view.bounds.size.height = CGFloat(height * 32)
//        print(view.bounds.size)
        let tapRec = UITapGestureRecognizer()
        tapRec.numberOfTapsRequired = 1
        tapRec.addTarget(self, action: "tappedView:")
        
        self.view!.addGestureRecognizer(tapRec)
        let doubleTouchRec = UITapGestureRecognizer()
        doubleTouchRec.numberOfTouchesRequired = 2
        doubleTouchRec.addTarget(self, action: "doubleTouch:")
        self.view!.addGestureRecognizer(doubleTouchRec)
        let tripleTapRec = UITapGestureRecognizer()
        tripleTapRec.numberOfTapsRequired = 3
        tripleTapRec.addTarget(self, action: "tripleTap:")
        self.view!.addGestureRecognizer(tripleTapRec)
        let doubleTapRec = UITapGestureRecognizer()
        doubleTapRec.numberOfTapsRequired = 2
        doubleTapRec.addTarget(self, action: "doubleTap:")
        self.view!.addGestureRecognizer(doubleTapRec)
        tapRec.requireGestureRecognizerToFail(doubleTapRec)
        tapRec.requireGestureRecognizerToFail(tripleTapRec)
        doubleTapRec.requireGestureRecognizerToFail(tripleTapRec)
//        print("townhall in map", convertPoint(townHall1.position, toNode:map))
        constrainCameraPosition(convertPoint(townHall1.position, toNode:map))
        
        self.setTimer()
    }
    func didBeginContact(contact: SKPhysicsContact) {
//        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//        if((collision == 0b11 || collision ==  0b110 || collision == 0b010) && buildMode == true && (contact.bodyA.node === created || contact.bodyB.node === created)){
//            buildCollisions++
//            //print("COLLISON")
//        }
    }
    func didEndContact(contact: SKPhysicsContact) {
//        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//        if((collision == 0b11 || collision ==  0b110 || collision == 0b010) && buildMode == true && (contact.bodyA.node === created || contact.bodyB.node === created)){
//            buildCollisions--
//            //print("END COLLISION")
//        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        lastTouchPosition = touches.first!.locationInNode(self)
        if (buildMode == true) {
            //created.physicsBody?.dynamic = true
            created.position = convertPoint(lastTouchPosition, toNode: map)
            positionOnTile(created)
            setNewBuildingTint()
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        if (buildMode == false) {
            let newTouchPosition = touches.first!.locationInNode(self)
            let touchOffsetVector = CGPointMake(newTouchPosition.x - lastTouchPosition.x, (newTouchPosition.y - lastTouchPosition.y) )
            let mapCameraPositionInScene = convertPoint(map.camera.position, toNode: self)
            let newCameraPosition = CGPointMake(mapCameraPositionInScene.x - touchOffsetVector.x, mapCameraPositionInScene.y - touchOffsetVector.y)
            constrainCameraPosition(newCameraPosition)
            lastTouchPosition = newTouchPosition
    //        print(map.camera.position)
        }
        else {
            isMoving = true
            didMove = true
            let newTouchPosition = touches.first!.locationInNode(self)
//            let touchOffsetVector = CGPointMake(newTouchPosition.x - lastTouchPosition.x, (newTouchPosition.y - lastTouchPosition.y) )
//            created.position = CGPointMake(created.position.x + touchOffsetVector.x, created.position.y + touchOffsetVector.y)
            lastTouchPosition = newTouchPosition
            setNewBuildingTint()
            
        }

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("TOUCHES ENDED")
        if(created != nil && created.physicsBody?.allContactedBodies().count == 0){
            placeNewBuilding()
        }
        setNewBuildingTint()
        isMoving = false
    }
    
    func constrainCameraPosition(var newCameraPosition: CGPoint) {
        //print(newCameraPosition)
        if newCameraPosition.x < 0 {
            newCameraPosition.x = 0
        } else if newCameraPosition.x > ((CGFloat(width)) * TILE_WIDTH - frame.size.width) {
            newCameraPosition.x = ((CGFloat(width)) * TILE_WIDTH - frame.size.width)
        }
        
        if newCameraPosition.y < -((CGFloat(height)) * TILE_HEIGHT - frame.size.height) {
            newCameraPosition.y = -((CGFloat(height)) * TILE_HEIGHT - frame.size.height)
        } else if newCameraPosition.y > 0 {
            newCameraPosition.y = 0
        }
        
        map.camera.position = newCameraPosition
        
    }
    
    func infiniteScroll(let locationTouched: CGPoint) {
        let cameraCenter = CGPointMake(map.camera.position.x + self.frame.width/2, map.camera.position.y - self.frame.height/2)
        let sceneTouched = convertPoint(locationTouched, toNode: map)
        //print(getAngle(cameraCenter, endingPoint: sceneTouched), "angle")
        let offset = CGPointMake(sceneTouched.x - cameraCenter.x, sceneTouched.y - cameraCenter.y)
        let length = sqrt(offset.x * offset.x + offset.y * offset.y)
        //let movementScalar = CGFloat(length * 0.25)
        let movementScalar = CGFloat(15)
        let direction = CGPointMake(offset.x * movementScalar / length, offset.y * movementScalar / length)
        created.position = sceneTouched
        positionOnTile(created)
        if(abs(offset.x) > self.frame.width * 0.25 || abs(offset.y) > self.frame.height * 0.25) {
            constrainCameraPosition(CGPointMake(map.camera.position.x + direction.x, map.camera.position.y + direction.y))
        }

    }
    
    override func update(currentTime: CFTimeInterval) {

        if (buildMode == true && isMoving) {
            infiniteScroll(lastTouchPosition)
        }
        if (buildMode == true && !isMoving && didMove && created.physicsBody?.allContactedBodies().count == 0) {
            placeNewBuilding()
        }
        if (didMove == false && buildMode == true) {
            setNewBuildingTint()
        }
    }
    
    func placeNewBuilding() {
        buildMode = false
        didMove = false
        created.colorBlendFactor = CGFloat(0)
        created.color = SKColor.clearColor()
        created.zPosition = 2
        created = nil
    }
    
    func setNewBuildingTint() {
        if(created != nil) {
            if(created.physicsBody?.allContactedBodies().count == 0) {
                created.colorBlendFactor = CGFloat(0.5)
                created.color = SKColor.greenColor()
            }
            else {
                created.colorBlendFactor = CGFloat(0.5)
                created.color = SKColor.redColor()
            }
        }
    }
    
    func positionOnTile(nodeToBePositioned: SKNode) {
        let nodes = map.nodesAtPoint(created.position)
        for node in nodes {
            if (node is Tile) {
                nodeToBePositioned.position = node.position
            }
        }
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
    func doubleTouch(recognizer:UITapGestureRecognizer) {
//        self.createPeasant()

            if didSelect == false{
                self.view!.addSubview(tile)
                self.didSelect = true
            }
            else{
                tile.removeFromSuperview()
                self.didSelect = false
            }

    }
    
    func doubleTap(recognizer:UITapGestureRecognizer) {
        if (buildMode) {
            return
        }
        let viewTouchLocation = recognizer.locationInView((self.view))
        let sceneTouchLocation = self.convertPointFromView(viewTouchLocation)
        var touchedNode = self.nodeAtPoint(sceneTouchLocation)
        if(touchedNode is SKShapeNode){
            touchedNode = touchedNode.parent!
        }
        print("DOUBLE")
        
        if(!(touchedNode is Unit)) {
            if(selected != nil) {
                if(selected is Peasant) {
                    if(touchedNode is GoldMine){
                        print("GATHER GOLD")
                        self.gatherGold(touchedNode as! SKSpriteNode)
                    }
                    else if(touchedNode is TileTree){
                        print("GATHER WOOD")
                        self.gatherLumber(touchedNode as! SKSpriteNode)
                    }
                    else{
                        moveSprite(self.selected, touchedSprite: touchedNode as! SKSpriteNode)
                        Sound.playEffect("acknowledge1.wav", subdirectory: "peasant")
                    }
                }
            }
        }
    }
    
    func tripleTap(recognizer:UITapGestureRecognizer) {
        if (buildMode) {
            return
        }
        let viewTouchLocation = recognizer.locationInView((self.view))
        let sceneTouchLocation = self.convertPointFromView(viewTouchLocation)
        var touchedNode = self.nodeAtPoint(sceneTouchLocation)
        let middleScene = CGPointMake(map.camera.position.x + self.frame.width/2, map.camera.position.y - self.frame.height/2)
        //let middlePoint = convertPoint(middleScene, toNode: map)
        if (selected is Peasant) {
            print("Triple")
            created = (selected as! Peasant).build("ScoutTower", location: middleScene)
            created.zPosition = 6
            map.addChild(created)
            buildMode = true
            positionOnTile(created)
            //setNewBuildingTint()
            
        }
    }
    
//    func setBuildingLocation(recognizer: UIPanGestureRecognizer) {
//        let translation = recognizer.translationInView(self.view)
//        let sceneTouchLocation = self.convertPointFromView(translation)
//        let convertedPoint = convertPoint(sceneTouchLocation, toNode: map)
//        created.position = convertedPoint
//    }
    
    func tappedView(recognizer:UITapGestureRecognizer) {
        if (buildMode) {
            didMove = true
            return
        }
        
        let viewTouchLocation = recognizer.locationInView((self.view))
        let sceneTouchLocation = self.convertPointFromView(viewTouchLocation)
        var touchedNode = self.nodeAtPoint(sceneTouchLocation)
        if(touchedNode is SKShapeNode){
            touchedNode = touchedNode.parent!
        }
        print("SINGLE")
        
        print("assigned selected")
        previouslySelected = selected
        selected = touchedNode
        
        if(selected is Peasant){
            print( (selected as! Peasant).HP)
        }
        
        if(selected != previouslySelected && selected is Unit){
            if(previouslySelected != nil){
                previouslySelected.removeAllChildren()
            }
            if(selected != previouslySelected && selected is Peasant){
                Sound.playEffect("selected1.wav", subdirectory: "peasant")
            }
        }
        else if(selected != previouslySelected && selected is Tile){
            if(previouslySelected != nil){
                previouslySelected.removeAllChildren()
            }
            selected = nil
        }
        else if(selected != previouslySelected && selected is Building){
            if(previouslySelected != nil){
                previouslySelected.removeAllChildren()
            }
        }
        
        else if(selected is TownHall){
            if(previouslySelected != nil){
                previouslySelected.removeAllChildren()
            }
            createPeasant()
        }
    
        


        if(!(touchedNode is Tile)){
            let nodeSize = (touchedNode as! SKSpriteNode).size
            let highlight = SKShapeNode(rect: CGRectMake(-nodeSize.width/2, -nodeSize.height/2, nodeSize.width, nodeSize.height))
            highlight.lineWidth = 1.0
            highlight.userInteractionEnabled = false
            highlight.fillColor = SKColor.clearColor()
            highlight.strokeColor = SKColor.greenColor()
            touchedNode.addChild(highlight)
            highlight.zPosition = 1
        }
        
    }
    
    
    func gatherGold(goldMine: SKSpriteNode){
//        print("gathering gold")
        let selectedRef = self.selected
        let moveToGoldMine = SKAction.runBlock {
            //self.lightOn = true
            self.moveSprite(selectedRef, touchedSprite: goldMine)
        }
        let mineLit = SKAction.runBlock {
            self.lightUpMine(goldMine, light: true)
        }
        let delay = SKAction.waitForDuration(5)
        let mineUnlit = SKAction.runBlock { () -> Void in
            self.lightUpMine(goldMine, light: false)
        }
        let moveToTownHall = SKAction.runBlock {
            self.mining = true
            self.moveSprite(selectedRef, touchedSprite: self.townHall1)
            self.goldValue  += 100
            self.tile.menuPanel.goldLabel.text = "\(self.goldValue)"
            self.mining = false
        }
        selectedRef.runAction(SKAction.repeatActionForever(SKAction.sequence([moveToGoldMine, mineLit, delay, mineUnlit, moveToTownHall, delay])))
    }
    
    func gatherLumber(lumber: SKSpriteNode) {
//        print("gathering lumber")
        let selectedRef = self.selected
        let moveToTree = SKAction.runBlock { () -> Void in
            //self.lightOn = true
            self.moveSprite(selectedRef, touchedSprite: lumber)
        }
        let delay = SKAction.waitForDuration(5)
        let moveToTownHall = SKAction.runBlock { () -> Void in
            self.cutting = true
            self.cutTree(lumber)
            self.moveSprite(selectedRef, touchedSprite: self.townHall1)
            self.lumberValue  += 100
            self.tile.menuPanel.woodLabel.text = "\(self.lumberValue)"
            self.cutting = false
        }
        selected.runAction((SKAction.sequence([moveToTree, delay, moveToTownHall])))
    }
    
    
    func moveSprite(selectedSprite: SKNode, touchedSprite: SKSpriteNode) {
        let location = touchedSprite.position
//        print(touchedSprite.name, location)
        
        let distance                = sqrt(pow((location.x - selectedSprite.position.x), 2.0) + pow((location.y - selectedSprite.position.y), 2.0))    // Formula to keep the speed consistent.
        let moveDuration            = 0.005*distance
        let floatDuration           = NSTimeInterval(moveDuration)
        
        //var index = 0
        
        let angle = getAngle(selectedSprite.position, endingPoint: location)
        if mining == false {
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
        }
        else if mining == true{
            if((22.5 < angle) && (angle <= 67.5)) {
                self.setDirection(selectedSprite, index: 87)
            }
            if((67.5 < angle) && (angle <= 112.5)) {    // up
                self.setDirection(selectedSprite, index: 92)
            }
            if((112.5 < angle) && (angle <= 157.5)) {
                self.setDirection(selectedSprite, index: 57)
            }
            if((157.5 < angle) && (angle <= 202.5)) {   //left
                self.setDirection(selectedSprite, index: 62)
            }
            if((202.5 < angle) && (angle <= 247.5)) {
                self.setDirection(selectedSprite, index: 67)
            }
            if((247.5 < angle) && (angle <= 292.5)) {   //down
                self.setDirection(selectedSprite, index: 152)
            }
            if((292.5 < angle) && (angle <= 337.5)) {
                self.setDirection(selectedSprite, index: 72)
            }
            if((337.5 < angle) || (angle <= 22.5)) {    //right
                self.setDirection(selectedSprite, index: 82)
            }
        }
//        print (mining)
        let moveAction = SKAction.moveTo(location, duration: floatDuration)
        let walkingAnimation = SKAction.animateWithTextures(peasantImages, timePerFrame: 0.05, resize: false, restore: true)
        let repeatedWalk = SKAction.repeatActionForever(walkingAnimation)
        selectedSprite.runAction(repeatedWalk, withKey: "animation")
        selectedSprite.runAction(moveAction, completion: { selectedSprite.removeActionForKey("animation")})
//        print(selectedSprite.name)
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
        let originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y) // get origin point to origin by subtracting end from start
        let bearingRadians = atan2(Double(originPoint.y), Double(originPoint.x)) // get bearing in radians
        var bearingDegrees = bearingRadians * (180.0 / M_PI) // convert to degrees
        bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)) // correct discontinuity
        return bearingDegrees
    }
    
    
    
    func lightUpMine(mine: SKSpriteNode, light: Bool){
        let content = FileManager.returnDatFileContents("GoldMine.dat")
        let contentArray = content!.componentsSeparatedByString("\n")
        var image = UIImage()
        var index = -1
        
        if(true == light){
            mine.name = "activeGoldMine"
            index = 1
        }
        else{
            mine.name = "goldmine"
            index = 2
        }
//        print(index)
        
        image = UIImage(named: "data/png/Goldmine.png")!
        
        let h = image.size.height
        let w = image.size.width
        
        let numberOfTiles = Int(contentArray[1]);
        
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
//        print(tile)
        //let activeGoldmine = SKSpriteNode(texture: SKTexture(CGImage: tile!))
        
        mine.texture = SKTexture(CGImage: tile!)
        
        //        peasant.position = convertPoint(CGPointMake(64, 64), fromNode: map)
        //activeGoldmine.position = location
        //activeGoldmine.name = "activeGoldmine"
        //peasant.yScale = -1
        //activeGoldmine.zPosition = 2
        //        timer!.fire()
        //map.addChild(activeGoldmine)
        
    }
    
    func cutTree(tree: SKSpriteNode){
        let content = FileManager.returnDatFileContents("Terrain.dat")
        let contentArray = content!.componentsSeparatedByString("\n")

        
        var image = UIImage()
        let index = 170
        
        
        image = UIImage(named: "data/png/Terrain.png")!
        let h = image.size.height
        let w = image.size.width
        
        let numberOfTiles = Int(contentArray[1]);
        
        let tile = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfTiles!))), w, h/CGFloat(numberOfTiles!)))
        //print(tile)
        //let activeGoldmine = SKSpriteNode(texture: SKTexture(CGImage: tile!))
        
        tree.texture = SKTexture(CGImage: tile!)
        
        //        peasant.position = convertPoint(CGPointMake(64, 64), fromNode: map)
        //activeGoldmine.position = location
        //activeGoldmine.name = "activeGoldmine"
        //peasant.yScale = -1
        //activeGoldmine.zPosition = 2
        //        timer!.fire()
        //map.addChild(activeGoldmine)
        
    }
    func createPeasant() {
        let loc = CGPointMake(townHall1.position.x - townHall1.size.width/2, townHall1.position.y + townHall1.size.height/2)
        let peasant = Peasant(location: loc)
        map.addChild(peasant)
    }

    
    func setTimer(){
        self.timer = NSTimer(timeInterval: 5, target: self.view!, selector: "loading", userInfo: nil, repeats: false)
    }
    
}
