//
//  ayarController.swift
//  cyrptoMessage
//
//  Created by turker bilge on 15.04.2016.
//  Copyright © 2016 Turker Guney. All rights reserved.
//

import UIKit
import CoreData

class ayarController: UIViewController {

    var aModel = dilPaketi()
    var List = []
    
    @IBOutlet weak var dilSecLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        if(List.count == 0){
           
            pushNewItem()
        }
        
        
        populateList()
        
        
        
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }


    
    @IBAction func dilSecAct(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            
            saveLang(0)
            print("English selected")
        case 1:
            
            saveLang(1)
            print("TÜRKÇE Segment selected")
        default:
            break; 
        }
        
    }
    
    func setLanguage(){
    
        let data:NSManagedObject = List[0] as! NSManagedObject
        let sira = data.valueForKey("gecerlidil") as? Int
        
        switch (Int(sira!)){
        
        
        case 0:
            break
            
        case 1:
            break
        
            
        default:
            break
        
        
        }
    
    
    
    }
    func pushNewItem(){
    
    
        let AppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let Context: NSManagedObjectContext = AppDel.managedObjectContext
        let EntDescrp = NSEntityDescription.entityForName("Dil", inManagedObjectContext: Context)
        let newItem = coreDataModel(entity:EntDescrp!,insertIntoManagedObjectContext: Context)
        newItem.gecerlidil = 0
        do {
            
            try Context.save()
            
            
        }catch _ {
            
            
        }
    
    
    
    }
    
    func populateList(){
    
    
        let AppDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let Context: NSManagedObjectContext = AppDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Dil")
        
        List = try! Context.executeFetchRequest(request)
        
    
        
        setLanguage()
    
    }
    
    func saveLang(aa:Int){
    
        if(List.count != 0){
            
            let appDelZ:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let ThecontextZ:NSManagedObjectContext = appDelZ.managedObjectContext
            
            let selectedItem:NSManagedObject = List[0] as! NSManagedObject
            
            
            selectedItem.setValue(aa, forKey: "gecerlidil")
            
            
            
            
            do {
                
                try ThecontextZ.save()
                
                setLanguage()
                
            }catch _ {
                
                
            }
            
        }
        
   
    
    
    
    }
    
    
}
