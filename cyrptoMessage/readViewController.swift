//
//  readViewController.swift
//  cyrptoMessage
//
//  Created by turker bilge on 14.04.2016.
//  Copyright © 2016 Turker Guney. All rights reserved.
//

import UIKit
import AVFoundation


class readViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    
    var captureSession:AVCaptureSession?
    var videoPreviewlayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var rlabel: UILabel!
    override func viewDidLoad() {
        
        cancelBtn.hidden = true
        rlabel.hidden = true
        
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func scanBtnAct(sender: AnyObject) {
        
        cancelBtn.hidden = false
        rlabel.hidden = false
        mainBtn.hidden = true
        
        
        
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        
        var error:NSError?
        let input:AnyObject!
        
        
        do {
        
            input = try AVCaptureDeviceInput(device: captureDevice)
        }catch let error1 as NSError{
            error = error1
            input = nil
        }
        if (error != nil){
        
        print("\(error?.localizedDescription)")
        
        return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(input as! AVCaptureInput)
        
        
        let captureMetaDataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetaDataOutput)
        
        
       captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        captureMetaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        
        videoPreviewlayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewlayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        videoPreviewlayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewlayer!)
        
        captureSession?.startRunning()
        
        view.bringSubviewToFront(rlabel)
        view.bringSubviewToFront(cancelBtn)
        view.bringSubviewToFront(mainBtn)
        
        
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
        
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if(metadataObjects == nil || metadataObjects.count == 0){
        
            qrCodeFrameView?.frame = CGRectZero
            
            rlabel.text = "No Secret Message"
            rlabel.textColor = UIColor.blackColor()
            
            return
    
        }
        
        
        let metaDataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        
        if(metaDataObj.type == AVMetadataObjectTypeQRCode){
        
        
            let BarCodeObject = videoPreviewlayer?.transformedMetadataObjectForMetadataObject(metaDataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            
            qrCodeFrameView?.frame = BarCodeObject.bounds
            
            if(metaDataObj.stringValue != nil){
            
            
            rlabel.text = metaDataObj.stringValue
            rlabel.textColor = UIColor.redColor()
                
            
                
            }
        
        
        }
        
    }
    
    @IBAction func cancelBtnAct(sender: AnyObject) {
        
        cancelBtn.hidden = true
        rlabel.hidden = true
        
        mainBtn.hidden = false
        
        captureSession?.stopRunning()
        qrCodeFrameView?.removeFromSuperview()
        videoPreviewlayer?.removeFromSuperlayer()
        
        
    }
    
    @IBOutlet weak var mainBtnAct: UIButton!
    

}
