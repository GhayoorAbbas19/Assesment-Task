//
//  ApiManager.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation
import Alamofire
//Mark: - API Calling
class ApiManager {
    
    
    
    static func CallApi<T: Decodable>(APIMethodName : String,methodType:HTTPMethod, completion: @escaping (T?) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            
            
            UserInterfaceManager.showAlert(title: "Network Error", message: StringErrors.noInternet)
        }
        else{
            let url = "\(APIMethodName)"
            print(url)
            
            Alamofire.request(url, method: methodType, encoding: JSONEncoding.default).responseJSON { response in
                
                if let status = response.response?.statusCode {
                    print(status)
                    switch(status){
                    case 200:
                        if response.result.value != nil {
                            do {
                                
                                let obj = try JSONDecoder().decode(T.self, from: response.data!)
                                completion(obj)
                            }
                            catch{
                                
                                print(error.localizedDescription)
                                completion(nil)
                                print("Model Not Mapped due To ->>",error)
                                print(" Error: While Parsing JSON (Invalid Model Object  )")
                            }
                            
                        }else {
                            
                            
                            completion(nil)
                            print("***====*** No JSON Data")
                        }
                        
                    case 401:
                        completion(nil)
                        
                        print("401: Session Expied")
                    case 204:
                        completion(nil)
                        
                        print("204: No Record")
                        
                    default:
                        
                        completion(nil)
                        UserInterfaceManager.showAlert(title: "Error", message: StringErrors.serverError)
                        print("-=-=-=-= Error: in API Path")
                    }
                    
                } else {
                    
                    completion(nil)
                    print("=-=-=-=-=-Error:  No Response from API / ")
                }
            }
        }
        
        
        
    }//end without parameters
    
}


extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}


