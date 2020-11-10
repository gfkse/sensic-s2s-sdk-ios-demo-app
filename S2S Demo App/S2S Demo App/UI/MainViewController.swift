import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var vodButton: UIButton!
    @IBOutlet weak var liveButton: UIButton!
    @IBOutlet weak var liveNoSeekButton: UIButton!
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleUI()
    }
    
    private func styleUI() {
        setNavigationBarTitle(title: "S2S Demo App for iOS")
        vodButton.setUpLayer(button: vodButton, title: "Video on Demand")
        liveButton.setUpLayer(button: liveButton, title: "LIVE")
        liveNoSeekButton.setUpLayer(button: liveNoSeekButton, title: "LIVE (No Seek)")
        contentButton.setUpLayer(button: contentButton, title: "Content")
        settingsButton.setUpLayer(button: settingsButton, title: "Settings")
    }
}
