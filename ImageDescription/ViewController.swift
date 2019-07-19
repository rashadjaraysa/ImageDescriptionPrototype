//
//  ViewController.swift
//  ImageDescription
//
//  Created by Rashad Jaraysa on 7/17/19.
//  Copyright © 2019 Rashad Jaraysa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imgDescription : String = ""
    
    //var urlArray = ["","","","","","","","","","","","","","",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageAnalyze : RequestObject = RequestObject.init(url: "https://images1.americanlisted.com/nlarge/blue-eyes-siberian-husky-puppies-americanlisted_102019335.jpg")
        
        imageAnalyze.sendRequest()
        
        displayImg(url: URL(string: "https://images1.americanlisted.com/nlarge/blue-eyes-siberian-husky-puppies-americanlisted_102019335.jpg")!)
        
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        descriptionText.text = self.imgDescription
    }
    
    func displayImg(url: URL)
    {
        let data = try? Data(contentsOf: url)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            imageView.image = image!
        }
        else{
            print("Error getting the image. Please make sure the url is correct!")
        }
    }

}

