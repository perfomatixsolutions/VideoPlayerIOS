//
//  PlayVideoCollectionViewCell.swift
//  SmoothVideoPlayer
//
//  Created by Manu on 10/09/20.
//  Copyright © 2020 perfomatix. All rights reserved.
//

import UIKit
import GSPlayer
import AVFoundation

class PlayVideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: PlayVideoCollectionViewCell.self)
    
   
   //var playerView: CustomVideoPlayerView!
    var playerView = VideoPlayerView()
    
    @IBOutlet weak var videoPlayerBgView    : UIView!
    @IBOutlet weak var profileBgView        : UIView!
    @IBOutlet weak var profileImageView     : UIImageView!
    @IBOutlet weak var profileLabel         : UILabel!
  
    @IBOutlet weak var nameButton           : UIButton!
   

    @IBOutlet weak var timeLabel            : UILabel!
   
    @IBOutlet weak var bottomGradientView   : UIView!
   
    
    let topGradient     = CAGradientLayer()
    let bottomGradient  = CAGradientLayer()
    private var url: URL!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //playerView = CustomVideoPlayerView(frame: videoPlayerBgView.bounds, filter: .none)
        videoPlayerBgView.insertSubview(playerView, at: 0)
        //playerView.fillSuperview()
        playerView.playerLayer.videoGravity = .resizeAspectFill
        let ratio = UIScreen.main.bounds.width / 500
        playerView.playerLayer.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: ratio * 1080))
        playerView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: ratio * 1080))
        
    }
    func makeAnimate(){
        self.profileBgView.transform = CGAffineTransform(translationX: self.profileBgView.bounds.origin.x + 300, y: self.profileBgView.bounds.origin.y)
                                self.nameButton.transform = CGAffineTransform(translationX: self.nameButton.bounds.origin.x + 300, y: self.nameButton.bounds.origin.y)
                                 self.timeLabel.transform = CGAffineTransform(translationX: self.timeLabel.bounds.origin.x + 300, y: self.timeLabel.bounds.origin.y)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
         UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                   }) { (true) in
                       UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                           
                           self.nameButton.transform = .identity
                           self.profileBgView.transform = .identity
                          self.timeLabel.transform = .identity
                         
                       }) { (true) in
                                  UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                                
                                  }, completion: nil)
                       }
                   }
        
         }
    }

    func stopVideo() {
       // playerView.player = nil
       playerView.pause(reason: .hidden)
    }
    func pauseVideo(){
       // playerView.player?.pause()
          playerView.pause(reason: .hidden)
    }
    func set(url: URL) {
        self.url = url
    }
    func play() {
        playerView.play(for: url)
        self.getplayerstate()
        
    }
    
    func getplayerstate(){
        playerView.stateDidChanged = { state in
            switch state {
            case .none:
               print("none")
            case .error(let error):
                print("error - \(error.localizedDescription)")
            case .loading:
                print("loading")
            case .paused(let playing, let buffering):
                print("paused - progress \(Int(playing * 100))% buffering \(Int(buffering * 100))%")
            case .playing: break
             
            }
        }
    }


    
}
