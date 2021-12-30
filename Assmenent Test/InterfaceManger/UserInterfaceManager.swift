//
//  UserInterfaceManager.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import Foundation
import UIKit
class UserInterfaceManager:NSObject{
    
    
    static let shared = UserInterfaceManager()
    
    
    
    static func showAlert(title:String?, message:String?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in })
        UserInterfaceManager().topViewController()!.present(alert, animated: true){}
    }
 
    
    func topViewController(base: UIViewController? = Constants.sceneDelegate.window?.rootViewController) -> UIViewController?{
        
        if let nav = base as? UINavigationController{
            
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController{
            
            if let selected = tab.selectedViewController{
                
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController{
            
            return topViewController(base: presented)
        }
        return base
    }
 
    func printDictToJson(dict:NSDictionary){
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dict,
            options: [.prettyPrinted]) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
            
            print("JSON string = \(theJSONText!)")
        }
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
//        inputFormatter.dateFormat = "dd/MM/yyyy"
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {

          let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }
    
    func minutesToHoursAndMinutes (_ minutes : Int) -> (hours : Int , leftMinutes : Int) {
     
        return (minutes / 60, (minutes % 60))
        
    }
    
}

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

