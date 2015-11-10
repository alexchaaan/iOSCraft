//
//  DescriptionAndActions.swift
//  DavisCraft
//
//  Created by Javier Perez on 11/1/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit

class IconsRender: UIView {
    var woodLabel = UILabel()
    var label = UILabel()
    var goldLabel = UILabel()
    //each map tile is 32x32
    let bundle = NSBundle.mainBundle()
    func readIcons() -> (Dictionary <String, CGImage>?, Array<String>) {
        //read in the icons for the icons
        let fileName = "Icons.dat"
        let iconsDat = FileManager.returnDatFileContents(fileName)
        let iconsDatContent = iconsDat!.componentsSeparatedByString("\n")
        let iconsPngPath = iconsDatContent[0]
        let numberOfIcons = Int(iconsDatContent[1])
        var iconsDictionary = [String: CGImage]()
        let image = UIImage(named: "data/png/Icons.png")
        let h = image!.size.height
        let w = image!.size.width
        // let h: CGFloat = 64
        //let w: CGFloat = 64
        
        var counter = 2
        for var index = Int(numberOfIcons!); index > 0; index-- {
            iconsDictionary[iconsDatContent[counter]] = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfIcons!))), w, h/CGFloat(numberOfIcons!)))
            counter++
        }
        return (iconsDictionary, iconsDatContent)
        
    }
    
    func readMiniIcons() -> (Dictionary <String, CGImage>?, Array<String>) {
        //read in the icons for the mIcons
        let fileName = "MiniIcons.dat"
        let mIconsDat = FileManager.returnDatFileContents(fileName)
        let mIconsDatContent = mIconsDat!.componentsSeparatedByString("\n")
        let mIconsPngPath = mIconsDatContent[0]
        let numberOfmIcons = Int(mIconsDatContent[1])
        var mIconsDictionary = [String: CGImage]()
        let image = UIImage(named: "data/png/MiniIcons.png")
        //        let image = UIImage(
        let h = image!.size.height
        let w = image!.size.width
        //        let h: CGFloat = 64
        //        let w: CGFloat = 64
        
        var counter = 2
        for var index = Int(numberOfmIcons!); index > 0; index-- {
            //            mIconsDictionary[mIconsDatContent[counter]] = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfmIcons!))), w, h/CGFloat(numberOfmIcons!)))
            print(CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfmIcons!))), w, h/CGFloat(numberOfmIcons!)))
            )
            mIconsDictionary[mIconsDatContent[counter]] = CGImageCreateWithImageInRect(image?.CGImage, CGRectMake(0, h-(CGFloat(index)*(h/CGFloat(numberOfmIcons!))), w, h/CGFloat(numberOfmIcons!)))
            counter++
        }
        return (mIconsDictionary, mIconsDatContent)
        
    }
    
    func drawIcon(icon: Int, xDir: CGFloat, yDir: CGFloat) {
        //let a = IconsRender()
        var (iDictionary, iNames) = readIcons()
        let image = UIImage(CGImage: iDictionary![iNames[icon]]!)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(xDir, yDir, imageView.bounds.size.width, imageView.bounds.size.height)
        self.addSubview(imageView)
    }
    
    func drawWoodLabel(xDir: CGFloat, yDir: CGFloat, width: CGFloat, height: CGFloat, text: String, size: CGFloat){
        self.woodLabel = UILabel(frame: CGRectMake(xDir, yDir, width, height))
        //label.center = CGPointMake(160, 284);
        woodLabel.textAlignment = NSTextAlignment.Center
        woodLabel.text = text
        woodLabel.font = UIFont.systemFontOfSize(size)
        woodLabel.textColor = UIColor.whiteColor()
        self.addSubview(woodLabel)
    }
    
    func drawGoldLabel(xDir: CGFloat, yDir: CGFloat, width: CGFloat, height: CGFloat, text: String, size: CGFloat){
        self.goldLabel = UILabel(frame: CGRectMake(xDir, yDir, width, height))
        //label.center = CGPointMake(160, 284);
        goldLabel.textAlignment = NSTextAlignment.Center
        goldLabel.text = text
        goldLabel.font = UIFont.systemFontOfSize(size)
        goldLabel.textColor = UIColor.whiteColor()
        self.addSubview(goldLabel)
    }
    
    func drawLabel(xDir: CGFloat, yDir: CGFloat, width: CGFloat, height: CGFloat, text: String, size: CGFloat){
        self.label = UILabel(frame: CGRectMake(xDir, yDir, width, height))
        //label.center = CGPointMake(160, 284);
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        label.font = UIFont.systemFontOfSize(size)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    func drawMIcon(icon: Int, xDir: CGFloat, yDir: CGFloat) {
        //        let a = IconsRender()
        var (iDictionary, iNames) = readMiniIcons()
        let image = UIImage(CGImage: iDictionary![iNames[icon]]!)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(xDir, yDir, imageView.bounds.size.width, imageView.bounds.size.height)
        self.addSubview(imageView)
    }
    
    func drawPeasant() {
        var (iDictionary, iNames) = readIcons()
        let  size = 44
        //UIImage(CGImage: iDictionary![iNames[icon]]!).drawAtPoint(location)
        //        let peasant = UIImageView(image: UIImage(CGImage: iDictionary![iNames[3]]!))
        let humanMove = UIImageView(image: UIImage(CGImage: iDictionary![iNames[85]]!))
        let repair = UIImageView(image: UIImage(CGImage: iDictionary![iNames[87]]!))
        let mine = UIImageView(image: UIImage(CGImage: iDictionary![iNames[88]]!))
        let buildSimple = UIImageView(image: UIImage(CGImage: iDictionary![iNames[89]]!))
        let humanWeapon1 = UIImageView(image: UIImage(CGImage: iDictionary![iNames[118]]!))
        let humanArmor1 = UIImageView(image: UIImage(CGImage: iDictionary![iNames[166]]!))
        humanMove.frame = CGRect(x: 13, y: 15, width: size, height: size)
        repair.frame = CGRect(x: 18 + size, y: 15, width: size, height: size)
        mine.frame = CGRect(x: 24 + size * 2, y: 15, width: size, height: size)
        buildSimple.frame = CGRect(x: 13, y: 25 + size, width: size, height: size)
        humanWeapon1.frame = CGRect(x: 18 + size, y: 25 + size, width: size, height: size)
        humanArmor1.frame = CGRect(x: 24 + size * 2, y: 25 + size, width: size, height: size)
        // let button = UIButton(frame: CGRect(x: 15, y: 15, width: 30, height: 30))
        //        button.imageView!.image = humanMove.image
        //        self.addSubview(button)
        
        self.addSubview(humanMove)
        self.addSubview(repair)
        self.addSubview(mine)
        self.addSubview(buildSimple)
        self.addSubview(humanWeapon1)
        self.addSubview(humanArmor1)
    }
    
    func drawHPBar (xDir: CGFloat, yDir: CGFloat, width: CGFloat, height: CGFloat){
        let hpBar: UIImageView = UIImageView(frame: CGRectMake(xDir, yDir, width, height))
        hpBar.backgroundColor = UIColor.greenColor()
        self.addSubview(hpBar)
    }
    
    func removeCurPanel(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
}

