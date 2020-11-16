import UIKit
import s2s_sdk_ios
import AVKit
import AVFoundation

class VODViewController: BaseViewController {
    
    private let vodUrl = "https://demo-config-preproduction.sensic.net/video/video3.mp4"
    
    @IBOutlet weak var playerView: UIView!
    
    private var player: AVPlayer!
    private var playerViewController: AVPlayerViewController!
    private var s2sAgent: S2SAgent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitle(title: "Video on Demand")
        setupVideoPlayer()
        
        do {
            s2sAgent = try S2SAgent(configUrl: "https://demo-config-preproduction.sensic.net/s2s-ios.json", mediaId: "s2sdemomediaid_ssa_ios_new")
        } catch let error {
            print(error)
        }
        
        if let agent = s2sAgent {
            //Important: Do not hold a strong reference to the extension
            let s2sExtension = S2SExtension(contentId: "contentId", customParams: ["":""])
            s2sExtension.bindAVPlayer(avPlayerController: playerViewController, s2sAgent: agent)
        }
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
