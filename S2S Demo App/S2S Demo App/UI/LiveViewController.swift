import UIKit
import s2s_sdk_ios
import AVKit
import AVFoundation

class LiveViewController: BaseViewController {
    
    private let liveUrl = "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8"
    
    @IBOutlet weak var playerView: UIView!
    
    private var player: AVPlayer!
    private var playerViewController: AVPlayerViewController!
    private var s2sAgent: S2SAgent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitle(title: "Live Video")
        setupVideoPlayer()
        do {
            s2sAgent = try S2SAgent(configUrl: "https://demo-config-preproduction.sensic.net/s2s-ios.json", mediaId: "s2sdemomediaid_ssa_ios_new")
        } catch let error {
            print(error)
        }
        
        if let agent = s2sAgent {
            //Important: Do not hold a strong reference to the extension
            let s2sExtension = S2SExtension(contentId: "contentId", customParams: ["":""])
            s2sExtension.bindAVLivePlayer(avPlayerController: self.playerViewController, s2sAgent: agent)
        }
    }
    
    //MARK: Videoplayer
    
    private func setupVideoPlayer() {
        player = AVPlayer(url: URL(string: liveUrl)!)
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.view.frame = playerView.bounds
        playerView.addSubview(playerViewController.view)
        playerViewController.view.backgroundColor = UIColor.clear
    }
}
