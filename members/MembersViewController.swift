//
//  MembersViewController.swift
//  MyMassage
//
//  Created by Lewis Liu on 30/6/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit
import AVKit

class MembersViewController: UIViewController {

    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var signup: UIButton!
    
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        Utilities.customizeFilledButton(signup)
        Utilities.customizeFilledButton(login)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVideo()
    }

    func setupVideo()
    {
        let bundlePath=Bundle.main.path(forResource: "massage", ofType: "mp4")
        guard bundlePath != nil else{
            print("not found massage file")
            return
        }
        let url = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url:url)
        videoPlayer=AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player:videoPlayer!)
        videoPlayerLayer?.frame=CGRect(x:-self.view.frame.size.width*1.5,
                                       y:0, width:self.view.frame.size.width*4,
                                       height:self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at:0)
        videoPlayer?.playImmediately(atRate: 1.0)
        //videoPlayer.pla
        
        videoPlayer?.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: videoPlayer?.currentItem)

        
        
    }
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signupTabbed(_ sender: Any) {
    }
    @IBAction func loginTapped(_ sender: Any) {
    }
}
