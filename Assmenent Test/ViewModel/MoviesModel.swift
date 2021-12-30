//
//  MoviesViewModel.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation


struct MoviesViewModel{
    
    
    func getMovies(completion : @escaping (_ result: [Result]?) -> Void) {
        
        var result:[Result]?
        
        ApiManager.CallApi(APIMethodName: Route.upcomingMovies.url() + Constants.apiKey, methodType: .get) { (Result:MoviesRespone!) in
            
            
            if Result != nil {
                
                let moviesResult = Result.results
                
                if moviesResult?.count ?? 0 > 0 && moviesResult != nil{
                    
                    result = moviesResult
                    
                    completion(result)
                }
                
            }
            else{
                completion(nil)
            }
            
        }
        
    }
    
}

