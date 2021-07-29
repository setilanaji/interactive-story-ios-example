//
//  Audio.swift
//  interactive story ios example
//
//  Created by Yudha S on 2021/7/30.
//  Copyright © 2021 Macx. All rights reserved.
//

import Foundation
import AudioToolbox

extension Story {
    
    var soundEffectName: String {
        switch self {
        case .droid, .home: return "HappyEnding"
        case .monster: return "Ominus"
        default: return "PageTurn"
        }
    }
        
    var soundEffectURL: URL {
        let path = Bundle.main.path(forResource: soundEffectName, ofType: "wav")!
        return URL(fileURLWithPath: path)
    }
}

class SoundEffectPlayer {
    // store sound
    var sound: SystemSoundID = 0
    
    func playSound(for story: Story) {
        let soundUrl = story.soundEffectURL as CFURL
        AudioServicesCreateSystemSoundID(soundUrl, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}
