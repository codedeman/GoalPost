//
//  LoginVC.swift
//  GoalPost
//
//  Created by Kien on 2/27/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    
    @IBOutlet var emailField: InsetTextField!
    
    @IBOutlet var passwordField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate =  self
        passwordField.delegate = self

    }
    
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        
        if emailField.text !=  nil && passwordField.text !=  nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success,loginError ) in
                if success {
                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "Main")
                    self.present(mainVC!, animated: true, completion: nil)
//                    self.dismiss(animated: true, completion: nil)
                }else{
                    let alertController = UIAlertController(title: "Erro", message: "Please check your password and email ", preferredStyle: .actionSheet)
                    let canceltAction = UIAlertAction(title: "OK", style: .destructive)
                    alertController.addAction(canceltAction)
                    self.present(alertController, animated: true, completion: nil)
//                    print(String(describing:loginError?.localizedDescription))
                }
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registrationError) in

                    if success{

                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
                            print("Sucessfully register user")
//                            self.dismiss(animated: true, completion: nil)
                        })
                    }else{
                        print(String(describing: registrationError?.localizedDescription))
                    }
                })
                
            }
        }
        
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier  == "GoalVC"{
            
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginVC:UITextFieldDelegate{
    
    
}
