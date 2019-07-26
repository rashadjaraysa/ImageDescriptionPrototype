//
//  ViewController.swift
//  ImagetoDB
//
//  Created by Abshir Mohamed on 7/19/19.
//  Copyright © 2019 Abshir Mohamed. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    var imgDescription : String = ""
    var imageObjects : [Images] = []
  
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let imageAnalyze : RequestObject = RequestObject.init()

        imageAnalyze.sendRequest() { isValid in
        print(isValid)
        DispatchQueue.main.async{
            self.imgDescription = imageAnalyze.caption
            self.imageObjects = imageAnalyze.imageObjects;
            }

        }
        
        
        _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.addToFirebase), userInfo: nil, repeats: false)
        addToFirebase()
        
}
    

    @objc func addToFirebase(){
        let ref = Database.database().reference()
        var imgObj:Images;
        if(self.imageObjects.count > 0){
            //Add image objects to firebase db
            for i in 0...imageObjects.count-1{
                imgObj = imageObjects[i]
                ref.child(String(i+1)).setValue(["url":imgObj.url,"caption":imgObj.caption,
                                                 "apiCaption":imgObj.apiCaption,"isDescribed":"false"])
            }
        }
    }

}
