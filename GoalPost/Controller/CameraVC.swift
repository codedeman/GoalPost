//
//  CameraVC.swift
//  GoalPost
//
//  Created by Kien on 3/23/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

import Photos
import AVFoundation

enum CameraTypes {
    case Front,Back,Both,None
    
}
class CameraVC: UIViewController {
    let cameraController = CameraController()

//    var captureSession:AVCaptureSession!
    var cameraOutput:AVCapturePhotoOutput!
    var  previewLayer:AVCaptureVideoPreviewLayer!
    
    @IBOutlet var camerButton: UIButton!
    @IBOutlet var capturePreviewView: UIView!
    @IBOutlet var  toggleCameraButton: UIButton!
    
    override var prefersStatusBarHidden: Bool { return true }

    
    var devices = AVCaptureDevice.devices(for: AVMediaType.video)
    
    lazy var availableCamera:CameraTypes = {
        
        
        if devices.count == 2 {
            self.toggleCameraButton.isHidden = false
            return .Both
        }else if devices.count == 1{
            
            self.toggleCameraButton.isHidden = true
            let device = (devices.first as! AVCaptureDevice)
            return (device.position == .front) ? .Front : .Back
            
            //
        }
        self.toggleCameraButton.isHidden = true
        self.camerButton.isHidden =  true
        return .None
        
        
    }()
    
    var captureSession =  AVCaptureSession()
    var stillImageOutput  = AVCaptureStillImageOutput()
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        camerButton.rounderButton()
        UIApplication.shared.setStatusBarHidden(true, with: .none)

//        func configureCameraController() {
//            cameraController.prepare {(error) in
//                if let error = error {
//                    print("this is \(error)")
//                }
//
//                try? self.cameraController.displayPreview(on: self.capturePreviewView)
//            }
//        }
//        configureCameraController()



    }
   

    override func viewDidAppear(_ animated: Bool) {
        
        
        let devices  =  AVCaptureDevice.devices(for: AVMediaType.video)
        
        for device in devices{
            
            //            if devi
            //            if device  == AVCaptureDevice.default(for: AVMediaType.video)
            
            if device.position ==  AVCaptureDevice.Position.front
                
            {
                
                do{
                    
                    let input = try AVCaptureDeviceInput(device: device)
                    
                    if  (captureSession.canAddInput(input))
                    {
                        captureSession.addInput(input)
                        if #available(iOS 11.0, *) {
                            stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecType.jpeg]
                        }
                        
                        
                        if captureSession.canAddOutput(stillImageOutput)
                        {
                            captureSession.addOutput(stillImageOutput)
                            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            
                            videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                            
                            videoPreviewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
//                            capturePreviewView.layer.addSublayer(videoPreviewLayer)
//                            videoPreviewLayer.frame = cameraView.bounds
//                            captureSession.startRunning()
                            capturePreviewView.layer.addSublayer(videoPreviewLayer)
                            videoPreviewLayer.frame = capturePreviewView.bounds
                            captureSession.startRunning()
                            
//                            capturePreviewView.position  = CGPoint(x: self.cameraView.frame.width/2, y: self.cameraView.frame.height)
                            capturePreviewView.bringSubviewToFront(camerButton)
                            
                            
                            
                            
                        }
                    }
                    
                    
                    
                    
                }catch{
                    
                    print(error)
                }
                
                
            }
            
        }
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
        
        
        let videoConnection = stillImageOutput.connection(with: AVMediaType.video)
        
        // capture a still image asynchronously
        stillImageOutput.captureStillImageAsynchronously(from: videoConnection ?? <#default value#>, completionHandler: { (imageDataBuffer, error) in
            
            if let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: imageDataBuffer!, previewPhotoSampleBuffer: imageDataBuffer!) {
//                self.stillImageOutput = UIImage(data: imageData)
                self.performSegue(withIdentifier: "showPhoto", sender: self)
            }
        })
        
//        if let videoConnection = stillImageOutput.connection(with: AVMediaType.video) {
//
//            stillImageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
//                // ...
//                // Process the image data (sampleBuffer) here to get an image file we can put in our captureImageView
//            })
//
//        }
        
//        cameraController.captureImage {(image, error) in
//            guard let image = image else {
//                print(error ?? "Image capture error")
//                return
//            }
//
//            try? PHPhotoLibrary.shared().performChangesAndWait {
//                PHAssetChangeRequest.creationRequestForAsset(from: image)
//            }
//        }
    }
    

}
