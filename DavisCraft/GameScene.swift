//
//  GameScene.swift
//  DavisCraft
//
//  Created by Charlie on 10/2/15.
//  Copyright (c) 2015 UCDClassNitta. All rights reserved.
//

import SpriteKit
import AVFoundation

@available(iOS 8.0, *)
var backgroundMusicPlayer = AVMIDIPlayer()

func playBackgroundMusic(filename: String) {
    //Load the soundfont
    let soundFontURL = NSBundle.mainBundle().URLForResource("generalsoundfont.sf2",
        withExtension: nil,
        subdirectory: "snd")
    
    //Load the midi file
    let url = NSBundle.mainBundle().URLForResource(filename,
        withExtension: nil,
        subdirectory: "snd/music")
    guard let midiURL = url else {
        print("Could not find file: \(filename)")
        return
    }
    

    
    
    do {
        let completion:AVMIDIPlayerCompletionHandler =
        {
                playBackgroundMusic(filename)
        }
            
        backgroundMusicPlayer = try AVMIDIPlayer(contentsOfURL: midiURL, soundBankURL:soundFontURL)
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play(completion)

    } catch let error as NSError {
        print(error.description)
    }
}

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
    }
    

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
