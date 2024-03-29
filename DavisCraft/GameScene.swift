
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
    var map = Map() //SKNode
    var lastTouchPosition = CGPointZero
    var selected : SKNode!
    var previouslySelected: SKNode!
    var newBuilding : Building!
    var newUnit : Unit!
    var buildMode = false
    var isMoving = false
    var didMove = false
    var peasantImages : [SKTexture] = []
    var width = Int()
    var height = Int()
    var townHall1 = TownHall(location: CGPointMake(2800, -1800))
    var timer: NSTimer?
    var goldValue: Int = 10000
    var lumberValue: Int = 10000
    var mining = false
    var cutting = false
    var lightOn = false
    //var actionPanelRender: ActionPanelRender!
//    var menuPanel: IconsRender!
    var dpanel: DescLabelRender?
    var apanel: ActionPanelRender?

    func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title): \(timeElapsed) s")
    }
    
    override func didMoveToView(view: SKView) {

        self.physicsWorld.contactDelegate = self
        anchorPoint = CGPointMake(0,1)
        
        // Clip the Viewport to Fit the size after sidePanel Added
        let default_width = self.size.width
        let default_height = self.size.height
        self.size = CGSizeMake(default_width * 3 / 4, default_height * 19 / 20)
        
        addChild(map)

        let mapRender = MapRender()
        (_, width, height ) = mapRender.readMap()
        printTimeElapsedWhenRunningCode("Adding Game Scene Map") { () -> () in
            mapRender.drawRect(self.map)
        }

        
        //map.addBuildingInBoth(townHall1)
        map.addChild(townHall1)
        MainViewController.miniMapScene.reflectSpriteToMini(townHall1)
        self.physicsWorld.gravity = CGVectorMake(0,0)
        self.physicsWorld.contactDelegate = self
        
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
        constrainCameraPosition(convertPoint(townHall1.position, toNode:map))
        
        
        
        
        self.setTimer()
    }
    func didBeginContact(contact: SKPhysicsContact) {
//        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//        if((collision == 0b11 || collision ==  0b110 || collision == 0b010) && buildMode == true && (contact.bodyA.node === newBuilding || contact.bodyB.node === newBuilding)){
//            buildCollisions++
//            //print("COLLISON")
//        }
    }
    func didEndContact(contact: SKPhysicsContact) {
//        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//        if((collision == 0b11 || collision ==  0b110 || collision == 0b010) && buildMode == true && (contact.bodyA.node === newBuilding || contact.bodyB.node === newBuilding)){
//            buildCollisions--
//            //print("END COLLISION")
//        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        print("BEGIN")
        lastTouchPosition = touches.first!.locationInNode(self)
        if (buildMode == true) {
            newBuilding = TownHall(location: lastTouchPosition)
            isMoving = true
            newBuilding.position = convertPoint(lastTouchPosition, toNode: map)
            Building.positionOnTile(newBuilding)
            Building.setNewBuildingTint(newBuilding)
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        if (buildMode == false) {
            let newTouchPosition = touches.first!.locationInNode(self)
            let touchOffsetVector = CGPointMake(newTouchPosition.x - lastTouchPosition.x, (newTouchPosition.y - lastTouchPosition.y) )
            let mapCameraPositionInScene = convertPoint(map.camera.position, toNode: self)
            let newCameraPosition = CGPointMake(mapCameraPositionInScene.x - touchOffsetVector.x, mapCameraPositionInScene.y - touchOffsetVector.y)
            constrainCameraPosition(newCameraPosition)
            var miniMapPosition = CGPointMake((newCameraPosition.x + MainViewController.gameWidth / 2) * MiniMapScene.ratio_x, (newCameraPosition.y - MainViewController.gameHeight / 2) * MiniMapScene.ratio_y)
            MainViewController.miniMapScene.confineViewPort(&miniMapPosition)
            MainViewController.miniMapScene.updateViewPort(miniMapPosition.x, y_pos: miniMapPosition.y)
            lastTouchPosition = newTouchPosition
        }
        else {

            didMove = true
            let newTouchPosition = touches.first!.locationInNode(self)
            lastTouchPosition = newTouchPosition
            Building.setNewBuildingTint(newBuilding)
            
        }

    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ENDED")
        if (newBuilding != nil && newBuilding.physicsBody?.allContactedBodies().count == 0) {
            Building.setNewBuildingTint(newBuilding)
            placeNewBuilding()
        }
        isMoving = false
    }
    
    func constrainCameraPosition(var newCameraPosition: CGPoint) {

        if newCameraPosition.x < -scene!.view!.bounds.size.width/4 {
            newCameraPosition.x = -scene!.view!.bounds.size.width/4
        } else if newCameraPosition.x > ((CGFloat(width)) * TILE_WIDTH - frame.size.width) {
            newCameraPosition.x = ((CGFloat(width)) * TILE_WIDTH - frame.size.width)
        }
        
        if newCameraPosition.y < -((CGFloat(height)) * TILE_HEIGHT - frame.size.height) {
            newCameraPosition.y = -((CGFloat(height)) * TILE_HEIGHT - frame.size.height)
        } else if newCameraPosition.y > 0 {
            newCameraPosition.y = 0
        }
        //print("New cam pos:", newCameraPosition)
        map.camera.position = newCameraPosition
        
    }
    
    func infiniteScroll(let locationTouched: CGPoint) {
        let cameraCenter = CGPointMake(map.camera.position.x + self.frame.width/2, map.camera.position.y - self.frame.height/2)
        let sceneTouched = convertPoint(locationTouched, toNode: map)
        let offset = CGPointMake(sceneTouched.x - cameraCenter.x, sceneTouched.y - cameraCenter.y)
        let length = sqrt(offset.x * offset.x + offset.y * offset.y)
        let movementScalar = CGFloat(25)
        let direction = CGPointMake(offset.x * movementScalar / length, offset.y * movementScalar / length)
        newBuilding.position = sceneTouched
        Building.setNewBuildingTint(newBuilding)
        Building.positionOnTile(newBuilding)
        if (abs(offset.x) > self.frame.width * 0.40 || abs(offset.y) > self.frame.height * 0.40) {
            constrainCameraPosition(CGPointMake(map.camera.position.x + direction.x, map.camera.position.y + direction.y))
        }

    }
    
    override func update(currentTime: CFTimeInterval) {
        if (buildMode) {
            if (isMoving) {
                infiniteScroll(lastTouchPosition)
            }
            if (!isMoving && didMove && newBuilding.physicsBody?.allContactedBodies().count == 0) {
                placeNewBuilding()
            }
            if (didMove == false) {
                Building.setNewBuildingTint(newBuilding)
            }
            
            if (!intersectsNode(newBuilding)) {
                newBuilding.position.x = (map.camera.position.x + (newBuilding.texture?.size().width)!/2)
            }
        }
    }
    
    func placeNewBuilding() {
        //if (intersectsNode(newBuilding)) {
        buildMode = false
        didMove = false
        newBuilding.colorBlendFactor = CGFloat(0)
        newBuilding.color = SKColor.clearColor()
        newBuilding.zPosition = 2
        newBuilding = nil
        //}
    }
    
    func printMe(buttonFunctionName: String) {
        switch(buttonFunctionName) {
        case "buildTownHall":
            print("hi")
            break
        case "buildFarm":
            break
        case "buildBarracks":
            break
        case "buildLumberMill":
            break
        case "buildScoutTower":
            break
        case "buildBlacksmith":
            break
        case "moveHere":
            break
        case "attackThis":
            break
        case "mineThis":
            break
        case "repairThis":
            break
        case "stayHere":
            break
        case "patrolHere":
            break
        case "buildPeasant":
            break
        case "buildKeep":
            break
        case "buildFootman":
            break
        case "buildArcher":
            break
        case "upgradeWeapon2":
            break
        case "upgradeArmor2":
            break
        case "buildCastle":
            break
        case "buildRanger":
            break
        case "upgradeArrow2":
            break
        case "buildGuardTower":
            break
        case "buildCannonTower":
            break
        default:
            break
            
        }
        
        
        
        
        

        //23 switch statements
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
        let middleScene = CGPointMake(map.camera.position.x + self.frame.width/2, map.camera.position.y - self.frame.height/2)
        if (selected is Peasant) {
            print("Triple")
            newBuilding = (selected as! Peasant).build("Barracks", location: middleScene)
            newBuilding.zPosition = 6
            map.addChild(newBuilding)
            buildMode = true
            Building.positionOnTile(newBuilding)
            
        }
    }
    
    
    func tappedView(recognizer:UITapGestureRecognizer) {
        if (buildMode) {
            didMove = true
            print("TAPPED")
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
        self.dpanel?.labelPrint(selected)
        self.apanel?.labelPrint(selected)
//        if(selected is Peasant){
//            print("selected is Peasant")
//            print( (selected as! Peasant).HP)
//            self.dpanel?.labelPrint(selected)
//            self.apanel?.labelPrint(selected)
//        }
       
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
        
        else if(selected is Barracks){
            if(previouslySelected != nil){
                previouslySelected.removeAllChildren()
            }
            newUnit = (selected as! Barracks).build("Footman")
            map.addChild(newUnit)
            
            
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
            print("before", menuPanel.goldLabel.text)
            menuPanel.goldLabel.text = "\(self.goldValue)"
            print("after", menuPanel.goldLabel.text)
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
            menuPanel.woodLabel.text = "\(self.lumberValue)"
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
        MainViewController.miniMapScene.reflectMovingSPToMini(selectedSprite, touchedSprite: touchedSprite, floatDuration: floatDuration)
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
        
        image = UIImage(named: "data/png/GoldMine.png")!
        
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
    func setDescPanelRender(panel: DescLabelRender) {
        self.dpanel = panel
    }
    
    func setActionPanelRender(panel: ActionPanelRender) {
        self.apanel = panel
    }
}
