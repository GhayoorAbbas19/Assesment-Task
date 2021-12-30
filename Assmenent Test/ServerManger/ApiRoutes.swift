//
//  ApiRoutes.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation


enum Route : String{
    
    
    case upcomingMovies     = "upcoming?api_key="
    case movieDetail        =  ""
    case movieVideo         = "%d/videos?api_key="
    

    func url() -> String{
        
        return Constants.baseUrl + self.rawValue
        
    }
    
}

