//
//  MoviesDetailVC.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class MoviesDetailVC : UIViewController{
    
    //MARK:- IBOUTLETS
    
    @IBOutlet weak var durationLbl:UILabel!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var revenueLbl: UILabel!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var overViewLbl:UITextView!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var movieImage:UIImageView!
    @IBOutlet weak var progressBar :UIActivityIndicatorView!
    @IBOutlet weak var trailerBtn :UIButton!
    
    
    //MARK:- VARIABLES
    private var viewModel = DetailViewModel()
    var movieId = 0
    var movieKey = ""
    var isTrailer = false

    
    override func viewDidLoad() {
        
        
        setUI()
        
        viewModel.getMovieDetail(id: movieId) { [self] Response in
            
            progressBar.stopAnimating()
            progressBar.isHidden = true
            
        
            if Response != nil {
            
                
                UIView.animate(withDuration: 1.5) {
                    
                    parentView.isHidden = false
                    parentView.alpha = 1
                    parentView.layer.opacity  =  1
                    
                    
                }
                
                
                let date = UserInterfaceManager.shared.formattedDateFromString(dateString: "\(Response?.releaseDate ?? "Date")", withFormat: "MMM d, yyyy")
                
                let minutes = UserInterfaceManager.shared.minutesToHoursAndMinutes(Response?.runtime ?? 0)
                
                let dropPath = Response?.posterPath ?? ""
                let imagePath = Constants.imageUrl + dropPath
                
                nameLbl.text =  Response?.title ?? "Title"
                durationLbl.text = " \(minutes.hours ) : \(minutes.leftMinutes) Hour"
                overViewLbl.text =  Response?.overview ?? "Movie Overview"
                revenueLbl.text =  "\(Response?.revenue ?? 0)$"
                dateLbl.text = date
                movieImage.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "PlaceHolder"), options: .progressiveLoad)
                
            }
            
            
        }
        
        viewModel.getMovieTrailer(id: movieId) { key , status in
            
            self.movieKey = key
            self.isTrailer = status

        }
        
        
    }
    
    func setUI(){
        
        progressBar.isHidden =  false
        progressBar.startAnimating()
        parentView.isHidden = true
        parentView.alpha = 0
        parentView.layer.opacity  =  0
        
    }
    
    @IBAction func playTrailor(_sender :UIButton){
        
        
        if isTrailer == false{
            
            UserInterfaceManager.showAlert(title: "Trailer", message: StringErrors.noTailer)
            
        }
        else{
         
            if Reachability.isConnectedToNetwork() == true{
             
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrailerVC") as! TrailerVC
                vc.movieKey =  movieKey
                self.present(vc, animated: true, completion: nil)
                
            }
            else{
                
                UserInterfaceManager.showAlert(title: "Network Error", message: StringErrors.noInternet)
                
            }
            
        }
        
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

