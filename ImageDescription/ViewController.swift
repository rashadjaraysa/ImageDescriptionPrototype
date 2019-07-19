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
    
    var urlArray = ["https://images1.americanlisted.com/nlarge/blue-eyes-siberian-husky-puppies-americanlisted_102019335.jpg","https://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/1508869913/matira-beach-bora-bora-french-polynesia-WHITESAND1017.jpg?itok=UwAUHGQs","https://www.washingtonpost.com/resizer/1BCTfoOR2b1uNLDK_GNNslmBhqA=/480x0/arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/WSM7ACU24AI6TGQW3RKR5JNEHM.jpg"]
    
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageAnalyze : RequestObject = RequestObject.init(url: "https://images1.americanlisted.com/nlarge/blue-eyes-siberian-husky-puppies-americanlisted_102019335.jpg")
        
        imageAnalyze.sendRequest() { isValid in
            print(isValid)
            DispatchQueue.main.async {
                self.imgDescription = imageAnalyze.caption
            }
        }
        
        displayImg(url: URL(string: "https://images1.americanlisted.com/nlarge/blue-eyes-siberian-husky-puppies-americanlisted_102019335.jpg")!)
        
    }

    @IBAction func btnPressed(_ sender: UIButton) {
        descriptionText.text = self.imgDescription
        
        if(count < urlArray.count-1)
        {
            count += 1
        }
        else
        {
            count = 0
        }
        displayImg(url: URL(string: urlArray[count])!)
        
        
    }
    
    func displayImg(url: URL)
    {
        let data = try? Data(contentsOf: url)
        
        if let imageData = data {
            let image = UIImage(data: imageData)
            UIView.transition(with: imageView,
                              duration: 0.75,
                              options: .transitionFlipFromLeft,
                              animations: { self.imageView.image = image },
                              completion: nil)
        }
        else{
            print("Error getting the image. Please make sure the url is correct!")
        }
    }

}

