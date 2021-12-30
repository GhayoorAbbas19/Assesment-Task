//
//  TrailerController.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import UIKit
import youtube_ios_player_helper

class TrailerVC: UIViewController, YTPlayerViewDelegate {

    //MARK:- Outlets
    
    @IBOutlet weak var playerView:YTPlayerView!
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    //MARK:- Variable
    
    var movieKey  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.startAnimating()
        playerView.delegate = self
        playerView.load(withVideoId: movieKey)
        
        
    }
    
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
        progressView.stopAnimating()
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        
       
        
        if state.rawValue == 1 {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        if state.rawValue == 4 {
            
            
        }
        
        // 2 play
        // 3 pause
        // loading
        // 1 for stop
        
    }
    
    
}
