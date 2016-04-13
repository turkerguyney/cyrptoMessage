//
//  ViewController.swift
//  cyrptoMessage
//
//  Created by turker bilge on 12.04.2016.
//  Copyright © 2016 Turker Guney. All rights reserved.
//

import UIKit
import Social
import AssetsLibrary
import Photos

class ViewController: UIViewController {
    
    
    
    var qrCodeImage:CIImage!
    
    let metaList: [String:String] = ["Developer": "Turker Bilge Guney"]
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var genButton: UIButton!
    
    
    
    @IBOutlet weak var imView: UIImageView!
    
    
    @IBOutlet weak var slider: UISlider!
    
    
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveAct(sender: AnyObject) {
        
  

        
       
    }
    
    
    
    @IBAction func twitButtonAct(sender: AnyObject) {
        
         /// performSegueWithIdentifier("selectViewSeq", sender:nil)
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let TwitSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            
            TwitSheet.setInitialText("Qr Code")
            TwitSheet.addImage(imView.image)
            
            self.presentViewController(TwitSheet, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please log into Twitter in your settings", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        
        
        
        
    }
    @IBAction func faceButtonAct(sender: AnyObject) {
        
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            
            let FacebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
           
            FacebookSheet.addImage(imView.image)
            
            self.presentViewController(FacebookSheet, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please log into facebook in your settings", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    
    
    
    @IBAction func genBtnAct(sender: AnyObject) {
        
        if(qrCodeImage == nil){
        
        
            if(textField.text == ""){
            
            
            return
            
            
            }
            
            textField.resignFirstResponder()
            
            
            
           let data = textField.text!.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrCodeImage = filter!.outputImage
            
            
            
            
            
            
            
            displayQRCodeImage()
            
            
            
            
            
            
            genButton.setTitle("Clear", forState: UIControlState.Normal)
           
            
        
        
        }else{
        
            imView.image = nil
            qrCodeImage = nil
            genButton.setTitle("Generate", forState: UIControlState.Normal)
            
        
        
        
        }
    
        textField.enabled = !textField.enabled
        slider.hidden = !slider.hidden
        
    }


    @IBAction func imageResizerAct(sender: AnyObject) {
        
        imView.transform = CGAffineTransformMakeScale(CGFloat(slider.value), CGFloat(slider.value))
    }


    func displayQRCodeImage() {
        let scaleX = imView.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = imView.frame.size.height / qrCodeImage.extent.size.height
        
        let transformedImage = qrCodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        
        
        
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer:true])
        let cgimg = softwareContext.createCGImage(transformedImage, fromRect: transformedImage.extent)
        
      
        
        
        imView.image = UIImage(CGImage: cgimg)
        
        
        
        

        
        
       
    }
    
    
    func saveImage(image: UIImage, path: String) -> Bool {
        let pngImageData = UIImagePNGRepresentation(image)
        let result = pngImageData!.writeToFile(path, atomically: true)
        return result
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let data = NSData(contentsOfFile: path)
        let image = UIImage(data: data!)
        return image
    }
    
    
    
    


}



