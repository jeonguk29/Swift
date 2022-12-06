//
//  VideoViewController.swift
//  BmiJjk12047
//
//  Created by comsoft on 2022/12/05.
//

import UIKit
import AVKit // 동영상 실행시 임포트 필요, 아래 소스 동작하게 하려면 필요함 
class VideoViewController: UIViewController {

    @IBAction func playVideo(_ sender: UIButton) {
        let file:String? = Bundle.main.path(forResource:"bmi", ofType: "mp4")
        let url = NSURL(fileURLWithPath: file!)
        let playerController = AVPlayerViewController()
        let player = AVPlayer(url: url as URL)
        playerController.player = player
        self.present(playerController, animated: true)
        player.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
