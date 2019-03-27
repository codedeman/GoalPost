//
//  CameraVC.swift
//  GoalPost
//
//  Created by Kien on 3/23/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CameraVC: UIViewController {
    let cameraController = CameraController()

    @IBOutlet var cameraView: UIView!
    @IBOutlet var camerButton: RoundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camerButton.rounderButton()
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                
                try? self.cameraController.displayPreview(on: self.cameraView)
            }
        }
        
      
        configureCameraController()
        
 

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraCapture(_ sender: Any) {
        
        cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            
            try? PHPhotoLibrary.shared().performChangesAndWait {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }
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
