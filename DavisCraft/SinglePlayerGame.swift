//
//  SinglePlayerGame.swift
//  ECS160Game
//
//  Created by Hidekazu Shidara on 10/4/15.
//  Copyright © 2015 Hidekazu Shidara. All rights reserved.
//

import UIKit

class SinglePlayerGame: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sound = AVAudioPlayerPool.returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd("explode.wav", subdir: "misc")
        sound?.prepareToPlay()
        sound?.play()
        
        // Uncomment for multiple sounds
//        let sound2 = AVAudioPlayerPool.returnAVAudioPlayerWithFilenameAndSubdirectoryWithinSnd("annoyed1.wav", subdir: "archer")
//        sound2?.prepareToPlay()
//        sound2?.play()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func didPressCancel(sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Options") as UIViewController?
//        self.presentViewController(vc!, animated: true, completion: nil)
//    }

}
