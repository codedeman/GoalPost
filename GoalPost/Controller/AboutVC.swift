//
//  AboutVC.swift
//  GoalPost
//
//  Created by Kien on 3/18/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView


class AboutVC: UIViewController,WKNavigationDelegate,NVActivityIndicatorViewable{
    static let activityData = ActivityData()

    @IBOutlet var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        NVActivityIndicatorView(frame: frame, type: type, color: color, padding: padding)
        
        startAnimating()
        let url = URL(string: "https://kienphamdev.blogspot.com/p/about-me.html")
        if let unwrappedURL = url{

            let request  = URLRequest(url: unwrappedURL)
            let session  = URLSession.shared
            let task  = session.dataTask(with: request){
                
                (data,response,err) in
                if err == nil{
                    
                    self.webView.load(request)
                }
                else{
                    
                    print("ERROR:\(String(describing: err))")
                }
            }
            task.resume()
            stopAnimating()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        let size = CGSize(width: 30.0, height: 30.0)
        startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
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

    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
