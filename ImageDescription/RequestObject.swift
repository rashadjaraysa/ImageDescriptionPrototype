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
    var imageUrl : URL
    
    var caption : String = "Awaiting for API"
    var tags : [String] = []
    
    //Remember to remove your key before pushing to github
    var apiKey = ""
    
    init(url :String)
    {
        imageUrl = URL(string: url)!
        request = URLRequest(url: endPointUrl)
    }
    
    func sendRequest(completion: @escaping (Bool) ->())
    {
        self.request.httpMethod = "POST"
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request.addValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        self.request.httpBody = "{\"url\":\"\(imageUrl)\"}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: self.request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let description = json["description"] as! [String : AnyObject]
                let captionsDict = description["captions"]?.firstObject as? [String : AnyObject]
                
                self.tags = description["tags"] as! [String]
                self.caption = (captionsDict?["text"] as? String)!
                
                print(self.caption)
                print(self.tags)
                completion(true)
            }catch{
                print("error")
            }
        })
        task.resume()
    }
}
