//import Foundation
//import Firebase
//
//class AuthService {
//
//    static let instance = AuthService()
//    func registerUser(withEmail email :String,andPassword password:String,userCreationComplete:@escaping(_ status:Bool,_ _error:Error)->())  {
//
//        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//            guard let user =  user else{
//                userCreationComplete(false,error!)
//                return
//            }
//
//            let userData = ["provider": user.providerID, "email": user.email]
//            DataService.instance.createDBUser(uid: user.uid, userData: userData)
//            userCreationComplete(true, nil)
//
//        }
//
//
//
//    }
//}

//
//  AuthService.swift
//  breakpoint
//
//  Created by Caleb Stultz on 7/24/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import Foundation
import Firebase

//impor




class AuthService {
    static let instance  = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            guard let authDataResult = authDataResult else {
                userCreationComplete(false, error)
                return
            }
            
            let userData = ["provider": authDataResult.user.providerID, "email" : authDataResult.user.email]
            DataService.instance.creteDBUser(uid: authDataResult.user.uid, userData: userData as Dictionary<String, Any>)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            guard authDataResult != nil else {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}
