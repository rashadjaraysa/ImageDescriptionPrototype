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
    var endPointUrl : URL
    var request : URLRequest
    var imageUrl : URL
    var caption : String
    var tags : [String]
    
    var apiKey = ""
    
    init(url :String)
    {
        imageUrl = URL(string: url)!
        endPointUrl = URL(string:"https://westcentralus.api.cognitive.microsoft.com/vision/v2.0/describe?maxCandidates=1")!
        request = URLRequest(url: endPointUrl)
        caption = "Waiting for API"
        tags = []
    }
    
    func sendRequest()
    {
        self.request.httpMethod = "POST"
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.addValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        self.request.httpBody = "{\"url\":\"\(imageUrl)\"}".data(using: .utf8)
        
        //let sem = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: self.request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let description = json["description"] as! [String : AnyObject]
                let captionsDict = description["captions"]?.firstObject as? [String : AnyObject]
                
                self.tags = description["tags"] as! [String]
                self.caption = (captionsDict?["text"] as? String)!
                
                print(self.caption)
                print(self.tags)
                
                //sem.signal()
            }catch{
                print("error")
            }
        })
        
       //DispatchSemaphore.wait(sem, DISPATCH_TIME_FOREVER)
        task.resume()
    }
}
