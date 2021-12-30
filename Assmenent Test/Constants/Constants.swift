//
//  Constants.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation
import UIKit

struct  Constants{
    
    static let sceneDelegate = UIApplication.shared.connectedScenes
           .first!.delegate as! SceneDelegate
    static var baseUrl = "https://api.themoviedb.org/3/movie/"
    static var imageUrl = "https://image.tmdb.org/t/p/w185"
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static var apiKey =  "c4a1cb2ad6f7c96d8cd690b93c19eb1a"
    
}

struct  StringErrors {
    
    static let serverError = NSLocalizedString("Error while connecting with server", comment: "")
    static let noInternet = NSLocalizedString("Please check your network connection and try again", comment: "")
    static let noTailer = NSLocalizedString("Movie's Trailer not aviable at this moment", comment: "")
    
}
