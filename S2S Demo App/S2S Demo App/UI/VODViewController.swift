//
//  VODViewController.swift
//  S2S Demo App
//
//  Created by Christian Müller on 13.10.20.
//

import UIKit
import s2s_sdk_ios
import AVKit
import AVFoundation

class VODViewController: BaseViewController {
    
    private let vodUrl = "https://demo-config-preproduction.sensic.net/video/video3.mp4"
    private let configUrl = "https://demo-config-preproduction.sensic.net/s2s-ios.json"
    
    @IBOutlet weak var playerView: UIView!
    
    private var player: AVPlayer!
    private var playerViewController: AVPlayerViewController!
    private var s2sAgent: S2SAgent?
    private var playerControlStatus: AVPlayer.TimeControlStatus?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitle(title: "Video on Demand")
        setupVideoPlayer()
        instantiateAgent()
        setupS2SExtension()
        
        NotificationCenter.default.addObserver(self,selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    //MARK: S2S Agent
    
    private func setupS2SExtension() {
        if let agent = s2sAgent {
            let s2sExtension = S2SExtension(contentId: "contentId", streamId: "streamId", customParams: ["":""])
            s2sExtension.bindAVPlayer(avPlayer: player, s2sAgent: agent)
        }
    }
    
    private func instantiateAgent() {
        do {
            s2sAgent = try S2SAgent(configUrl: configUrl, mediaId: "s2sdemomediaid_ssa_ios_new", streamPositionCallback: { [unowned self] in
                guard (self.player.currentTime().seconds * 1000) >= 0 else { return 0 }
                //return the player's current position. Typical pitfall: Do not! use return the content-length, but the playhead position.
                return UInt(self.player.currentTime().seconds * 1000) // we need to return milliseconds
            })
        } catch let error {
            print(error)
        }
    }
    
    //MARK: System Notifications
    
    @objc func didBecomeActive() {
        if playerControlStatus == .playing {
            player.play()
        }
    }
    
    @objc func didEnterBackground() {
        playerControlStatus = self.player.timeControlStatus
    }
    
    //MARK: Videoplayer
    
    func setupVideoPlayer() {
        player = AVPlayer(url: URL(string: vodUrl)!)
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.view.frame = playerView.bounds
        playerViewController.player?.pause()
        playerView.addSubview(playerViewController.view)
        playerViewController.view.backgroundColor = UIColor.clear
    }
}
