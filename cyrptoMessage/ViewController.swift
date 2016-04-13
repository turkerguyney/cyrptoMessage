//
//  ViewController.swift
//  cyrptoMessage
//
//  Created by turker bilge on 12.04.2016.
//  Copyright © 2016 Turker Guney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    var qrCodeImage:CIImage!
    
    
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

    @IBAction func genBtnAct(sender: AnyObject) {
        
        if(qrCodeImage == nil){
        
        
            if(textField.text == ""){
            
            
            return
            
            
            }
            
           let data = textField.text!.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrCodeImage = filter!.outputImage
            
           
            displayQRCodeImage()
            
            textField.resignFirstResponder()
            
            
            
            
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
        
        imView.image = UIImage(CIImage: transformedImage)
        
        
    }
    
    
    
    
    


}



