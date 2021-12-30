//
//  MoviesVc.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation
import UIKit
import SDWebImage

class  MoviesVC: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var tableView :UITableView!
    @IBOutlet weak var searchTf :UITextField!
    @IBOutlet weak var progressView :UIActivityIndicatorView!
    
    
    //MARK:- Variables
    
    private var viewModel = MoviesViewModel()
    var moviesArray = [Result]()
    var filterMoviesArray = [Result]()
    
    
    override func viewDidLoad() {
        
        setUI()
        
        getMovies()
        
        
    }
    
    func setUI(){
        
        tableView.isHidden =  true
        progressView.isHidden = false
        searchTf.isEnabled = false
        progressView.startAnimating()
        tableView.separatorStyle = .none
        
    }
    
    func getMovies(){
        
        if Reachability.isConnectedToNetwork(){
            
            viewModel.getMovies { [self] result in
                
                if result?.count ?? 0 > 0 && result != nil {
                    
                    moviesArray = result!
                    filterMoviesArray = result!
                    
                    DispatchQueue.main.async {
                        
                        tableView.isHidden = false
                        progressView.isHidden = true
                        searchTf.isEnabled = true
                        progressView.stopAnimating()
                        self.tableView.reloadData()
                    }
                    
                }
                else{
                    
                    progressView.isHidden = true
                    progressView.stopAnimating()
                    UserInterfaceManager.showAlert(title: "Server Error", message: StringErrors.serverError)
                 
                }
            }
            
        }
        else{
            
            let alert = UIAlertController(title: "Network Error", message: StringErrors.noInternet, preferredStyle: .alert)
            
            let tryAgain = UIAlertAction(title: "Try Again", style: .default) { alert in
                
                self.getMovies()
            }
            alert.addAction(tryAgain)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        
        
        
    }
    
    @IBAction func TFChangeEvent(_ sender: UITextField) {
        
        filterMoviesArray = sender.text?.isEmpty ?? false ? moviesArray : moviesArray.filter({(dataString: Result) -> Bool in
            
            // If dataItem matches the searchText, return true to include it
            return dataString.originalTitle?.range(of: sender.text ?? "", options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
        
    }
    
    
}

extension MoviesVC : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterMoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        
        
        let date = UserInterfaceManager.shared.formattedDateFromString(dateString: "\(filterMoviesArray[indexPath.row].releaseDate ?? "")", withFormat: "MMM d, yyyy")
        cell.movieDate.text  = date
        cell.movieTitle.text  = filterMoviesArray[indexPath.row].originalTitle ?? "Title"
        
        let path = filterMoviesArray[indexPath.row].posterPath ?? ""
        let imagePath = Constants.imageUrl + path
        cell.movieImage.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "PlaceHolder"), options: .progressiveLoad)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if Reachability.isConnectedToNetwork() == true{
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MoviesDetailVC") as! MoviesDetailVC
            vc.movieId =  filterMoviesArray[indexPath.row].id ?? 0
            self.present(vc,animated: true)
            
        }
        else{
            
            UserInterfaceManager.showAlert(title: "Network Error", message: StringErrors.noInternet)
            
        }
    }
    
}

