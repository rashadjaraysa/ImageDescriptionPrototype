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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference()
        
        let imageAnalyze : RequestObject = RequestObject.init()

        imageAnalyze.sendRequest() { isValid in
        print(isValid)
        DispatchQueue.main.async{
            self.imgDescription = imageAnalyze.caption
            self.imageObjects = imageAnalyze.imageObjects;
            }
            
        }
        
        
        _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.addToFirebase), userInfo: nil, repeats: false)
        self.addToFirebase()
        
//        ref.child
        
        //lines 21 and and 22 add data to DB
//        ref.child("1").setValue(["name":"Tom","role":"Admin","age":30])
//        ref.childByAutoId().setValue(["name":"Tom","role":"Admin","age":30])
        
        //lines 26 - 35 retrieve data from database
        
//        ref.child(String(1)).observeSingleEvent(of: .value)
//        {
//          Retrieves one value from specified key
//            (snapshot) in let name = snapshot.value as? Any
//
//            print(name)
            
//            If its more than one key value pair then then you can retrieve the data as a dictionary and get the pieces of data that you need from the dictionary
            
//            (snapshot) in let employeedata = snapshot.value as? [String:Any]
//        }
        
        //lines 37-44
        //update one value
//        ref.child("1").setValue(["name":"Abshir","role":"Admin","age":22])
    
        //Update multiple values
//        let updates = ["1": ["name":"Abshir","role":"Coolguy","age":22]]
//
//        ref.updateChildValues(updates)
    
        //line 49 deletes a value from the database
//        ref.child("1").removeValue()
//    }


}
    
   
    @objc func addToFirebase(){
        if(self.imageObjects.count > 0){
            //Add image objects to firebase db
            for img in imageObjects:
            {
                ref.child("1").setValue(["name":"Tom","role":"Admin","age":30])
            }
            
        }
        
    }
    

    @IBAction func nextButton(_ sender: UIButton) {
    }
    
//    func displayImg(url: URL)
//    {
//        let data = try? Data(contentsOf: url)
//
//        if let imageData = data {
//            let image = UIImage(data: imageData)
//            imageView.image = image!
//        }
//        else{
//            print("Error getting the image. Please make sure the url is correct!")
//        }
//    }

}
