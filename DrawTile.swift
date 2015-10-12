//
//  DrawTile.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/12/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit

class DrawTile: UIView {

    override func drawRect(rect: CGRect) {
        //let context = UIGraphicsGetCurrentContext()
        let image = UIImage(named: "Farm.png")
        //we can use CGPointMake to draw the images to specific location on map later
        let location = CGPointMake(0, 0)
        image?.drawAtPoint(location)
    }

}
