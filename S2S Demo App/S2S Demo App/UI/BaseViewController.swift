//
//  BaseViewController.swift
//  S2S Demo App
//
//  Created by Christian Müller on 12.10.20.
//

import UIKit
import AVKit
import AVFoundation

class BaseViewController: UIViewController {
    
    var player: CustomAVPlayer!
    var playerViewController: AVPlayerViewController!
    var videoUrl: String?
    
    @IBOutlet weak var playerView: UIView!
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.white.cgColor
        ]
        gradient.locations = [0.5, 1]
        return gradient
    }()

    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusBarStyle = .lightContent
        setNavigationBarGradient()
        gradient.frame = view.bounds
        view.layer.insertSublayer(gradient, at:0)
    }
    
    //MARK: NavigationBar
    
    private func setNavigationBarGradient() {
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor.orange.cgColor, UIColor.red.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            
            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }
    
    private func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        
        return gradientImage
    }
    
    func setNavigationBarTitle(title: String) {
        self.title = title
    }
    
    //MARK: Videoplayer
    
    func setupVideoPlayer() {
        if let videoURL = self.videoUrl {
            player = CustomAVPlayer(url: URL(string: videoURL)!)
            playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.view.frame = playerView.bounds
            playerViewController.player?.pause()
            playerView.addSubview(playerViewController.view)
            playerViewController.view.backgroundColor = UIColor.clear
            
            setupVideoPlayerObserver()
        }
    }
    
    private func setupVideoPlayerObserver() {
        player.addObserver(self, forKeyPath: #keyPath(AVPlayer.rate), options: NSKeyValueObservingOptions.new, context: nil)
        player.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: NSKeyValueObservingOptions.new, context: nil)
        
        player.didSeek = { toTime in
            print("Seeking started to: \(toTime.value)")
        }
        player.didPressSeekButton = {
            print("Seeking pressed")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayer.rate) {
            if player.rate > 0 {
                print("video started")
            } else {
                print("video pause/stopped")
            }
        } else if keyPath == #keyPath(AVPlayer.status) {
            
        }
    }
    
    func removeVideoPlayerObserver() {
        player.removeObserver(self, forKeyPath: #keyPath(AVPlayer.rate))
        player.removeObserver(self, forKeyPath: #keyPath(AVPlayer.status))
    }
}
