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

    var captureSession:AVCaptureSession!
    var cameraOutput:AVCapturePhotoOutput!
    var  previewLayer:AVCaptureVideoPreviewLayer!
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet var  camerButton: RoundedButton!
    @IBOutlet var  toggleCameraButton: UIButton!
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        camerButton.rounderButton()
        
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print("this is \(error)")
                }
                
                try? self.cameraController.displayPreview(on: self.cameraView)
            }
        }
        configureCameraController()



    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        previewLayer.frame =  cameraView.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
//        captureSession = AVCaptureSession()
//        captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
//        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
//        do{
//            let input =  try AVCaptureDeviceInput(device: backCamera!)
//            if captureSession.canAddInput(input)  ==  true{
//                captureSession.addInput(input)
//
//            }
//
//            cameraOutput =  AVCapturePhotoOutput();
//
//            if captureSession.canAddOutput(cameraOutput) == true {
//                captureSession.addOutput(self.cameraOutput)
//                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//                previewLayer.videoGravity =  AVLayerVideoGravity.resizeAspect
//                previewLayer.connection?.videoOrientation =  AVCaptureVideoOrientation.portrait
//                cameraView.layer.addSublayer(previewLayer!)
//                captureSession.startRunning()
//            }
//
//        }catch{
//
//            debugPrint(error)
//    }
    }
    
    
    @IBAction func switchCamera(_ sender: Any) {
        
        do {
            try cameraController.switchCameras()
        }
            
        catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(UIImage(named: "camera"), for: .normal)
            
        case .some(.rear):
            toggleCameraButton.setImage(UIImage(named: "camera"), for: .normal)

            
        case .none:
            return
        }
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
    

}
