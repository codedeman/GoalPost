//
//  AuthService.swift
//  GoalPost
//
//  Created by Kien on 2/27/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuhtService {
    
    static let instance = AuhtService()
    let defaults =   UserDefaults.standard
    var isLonggedIn:Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var authToke:String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
        
    }
    var userEmail:String{
        get{
            
            return defaults.value(forKey: USER_EMAIL) as! String
            
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL) as! String
        }
    }
    
    func registerUser(email:String,password:String,completion:@escaping CompletionHander) {
        
        let lowerCaseEmail  = email.lowercased()
        let header = ["Content-Type":"application/json; charset=utf-8"]
        let body:[String:Any] = ["email":lowerCaseEmail,"password":password]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    
    
}
