//
//  Tile.swift
//  DavisCraft
//
//  Created by Andrew Tran on 10/12/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import UIKit


class Tile: UIViewController{
     let tile = DrawTile(frame: CGRectMake(0, 0, 0, 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tile)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Pressed(sender: AnyObject) {
        tile.setNeedsDisplay()
        
    }
}





