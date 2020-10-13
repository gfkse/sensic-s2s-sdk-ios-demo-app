//
//  VODViewController.swift
//  S2S Demo App
//
//  Created by Christian Müller on 13.10.20.
//

import UIKit

class VODViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitle(title: "Video on Demand")
        videoUrl = "https://demo-config-preproduction.sensic.net/video/video3.mp4"
        setupVideoPlayer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //removeVideoPlayerObserver()
    }
}
