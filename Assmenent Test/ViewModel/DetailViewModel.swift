//
//  DetailViewModel.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation

struct DetailViewModel{

    
    func getMovieDetail(id:Int,completion : @escaping (_ result: DetailModel?) -> Void) {
        
        let url =  Route.movieDetail.url() + "\(id)" + "?api_key=\(Constants.apiKey)"
        
        ApiManager.CallApi(APIMethodName: url, methodType: .get) { (Result:DetailModel!) in
            
            if Result != nil {
                    
                completion(Result)
                
            }
            else{
                
                completion(nil)
            }
            
        }
        
    }
    
    
    func getMovieTrailer(id:Int,completion : @escaping (_ key: String , _ status :Bool ) -> Void) {
        
        
        let url = String(format: Route.movieVideo.url(), id) + "\(Constants.apiKey)"
        

        ApiManager.CallApi(APIMethodName: url, methodType: .get) { (Result:VideosModel!) in
            
            if Result != nil {
                    
                
                if Result.results?.count ?? 0 > 0 && Result.results != nil {
                    
                    
                    for a in Result.results!{
                        
                        if a.type == TypeEnum.trailer {
                        
                            completion(a.key ?? "" , true)
                            break
                        }
                    }
                }
                else{
                    completion( "" , false)
                    
                }
            }
            else{
                
                completion( "" , false)
            }
            
        }
        
    }
    
    
    
    
}
