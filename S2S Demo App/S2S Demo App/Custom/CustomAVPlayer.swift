//
//  CustomAVPlayer.swift
//  S2S Demo App
//
//  Created by Christian Müller on 13.10.20.
//

import AVFoundation

class CustomAVPlayer: AVPlayer {
    var didSeek: ((CMTime) -> Void)?
    var didPressSeekButton: (() -> Void)?
    
    override func seek(to time: CMTime, toleranceBefore: CMTime, toleranceAfter: CMTime, completionHandler: @escaping (Bool) -> Void) {
        super.seek(to: time, toleranceBefore: toleranceBefore, toleranceAfter: toleranceAfter, completionHandler: completionHandler)

        if toleranceBefore.value == 45000 || toleranceAfter.value == 45000 {
            didPressSeekButton?()
        }
        
        didSeek?(time)
    }
}
