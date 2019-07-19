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
        
        let url = URL(string: "https://westcentralus.api.cognitive.microsoft.com/vision/v2.0/describe?maxCandidates=1")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("96f2d53f13b74d6c88b2665b7b18aa77", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        request.httpBody = "{\"url\":\"https://images1.americanlisted.com/nlarge/blue-eyes-siberian-husky-puppies-americanlisted_102019335.jpg\"}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let description = json["description"] as! [String : AnyObject]
                let tags = description["tags"] as! [String]
                let captions = description["captions"]?.firstObject as? [String : AnyObject]
                self.imgDescription = (captions?["text"] as? String)!
                print(self.imgDescription)
                print(tags)
            }catch{
                print("error")
            }
        })
        
        task.resume()
        
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

