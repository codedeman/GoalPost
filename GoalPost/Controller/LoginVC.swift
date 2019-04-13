//
//  LoginVC.swift
//  GoalPost
//
//  Created by Kien on 2/27/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import Firebase


class LoginVC: UIViewController {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet var emailField: InsetTextField!
    
    @IBOutlet var passwordField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate =  self
        passwordField.delegate = self

    }
    func showActivityIndicatory(uiView: UIView) {
    
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.center =  uiView.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorView.Style.whiteLarge
        uiView.addSubview(actInd)
//        showActivityIndicatory.startAnimating()

    }
    override func viewDidAppear(_ animated: Bool) {
        
        _ = CGSize(width: 30.0, height: 30.0)
        

    }
    @IBAction func signInBtnWasPressed(_ sender: Any) {
        
        if emailField.text !=  nil && passwordField.text !=  nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success,loginError ) in
                if success {
                    
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
//                        
//                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
//                    }
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
    
    @IBAction func registerBtnWasPressed(_ sender: Any) {
        let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "Register")
        self.present(registerVC!, animated: true, completion: nil)
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
