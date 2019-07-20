//
//  RequestObject.swift
//  ImageDescription
//
//  Created by Rashad Jaraysa on 7/18/19.
//  Copyright © 2019 Rashad Jaraysa. All rights reserved.
//

import Foundation

class RequestObject
{
    var endPointUrl : URL = URL(string:"https://westcentralus.api.cognitive.microsoft.com/vision/v2.0/describe?maxCandidates=1")!
    var request : URLRequest
    var caption : String = "Awaiting for API"
    var tags : [String] = []
    
    var imageObjects : [Images] = []
    
    let imgs: [String] = [
        "https://www.tripsavvy.com/thmb/q7Lpi1WIoPs5Us2grWilqhy-3ms=/960x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-768071597-5c35995ac9e77c0001b82a80.jpg","https://cdn-image.travelandleisure.com/sites/default/files/styles/1600x1000/public/1508869913/matira-beach-bora-bora-french-polynesia-WHITESAND1017.jpg?itok=UwAUHGQs","https://cbsnews3.cbsistatic.com/hub/i/r/2018/10/11/1256ec76-ee78-47ab-b278-868b26f40e7d/thumbnail/1200x630/46bc54bbfe2a99dc73224c1cb3ff12ce/mb2.jpg",
        "https://cbsnews3.cbsistatic.com/hub/i/r/2018/10/11/1256ec76-ee78-47ab-b278-868b26f40e7d/thumbnail/1200x630/46bc54bbfe2a99dc73224c1cb3ff12ce/mb2.jpg",
        "https://thehill.com/sites/default/files/styles/thumb_small_article/public/andersoncooper_trump_cnn.png?itok=VnLddJN_",
        "https://www.petmd.com/sites/default/files/shutterstock_395310793.jpg",
        "https://images1.americanlisted.com/nlarge/blue-eyes-siberian-husky-puppies-americanlisted_102019335.jpg",
        "https://www.thesprucepets.com/thmb/wFSDYpmJJibM20qK2Hz7_FmtHAc=/450x0/filters:no_upscale():max_bytes(150000):strip_icc()/horse-galloping-in-grass-688899769-587673275f9b584db3a44cdf.jpg",
        "https://www.airc.ie/wp-content/uploads/horse-web.jpg",
        "https://www.washingtonpost.com/resizer/1BCTfoOR2b1uNLDK_GNNslmBhqA=/480x0/arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/WSM7ACU24AI6TGQW3RKR5JNEHM.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/LeBron_James_Layup_%28Cleveland_vs_Brooklyn_2018%29.jpg/325px-LeBron_James_Layup_%28Cleveland_vs_Brooklyn_2018%29.jpg",
    ]
    
    //Remember to remove your key before pushing to github
    var apiKey = "96f2d53f13b74d6c88b2665b7b18aa77"
    
    init()
    {
       request = URLRequest(url: endPointUrl)
    }
    
    func sendRequest(completion: @escaping (Bool) ->())
    {
       
        self.request.httpMethod = "POST"
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.addValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        
        for url in self.imgs{
            self.request.httpBody = "{\"url\":\"\(url)\"}".data(using: .utf8)
            let task = URLSession.shared.dataTask(with: self.request, completionHandler: { data, response, error -> Void in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    let description = json["description"] as! [String : AnyObject]
                    
                    let captionsDict = description["captions"]?.firstObject as? [String : AnyObject]
                    
                    self.tags = description["tags"] as! [String]
                    self.caption = (captionsDict?["text"] as? String)!
                    
                    self.imageObjects.append(Images.init(url,self.caption,self.tags))
            
                    completion(true)
                }catch{
                    print("error")
                }
            })
            task.resume()
        }
        
    }
   
    
    
    
}



