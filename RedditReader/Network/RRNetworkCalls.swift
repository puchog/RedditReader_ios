//
//  RRNetworkCalls.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRNetworkCalls: NSObject {
  
  let baseUrl = "https://www.reddit.com"
  
  static let sharedInstance : RRNetworkCalls = {
    let instance = RRNetworkCalls()
    return instance
  }()
  
  func retrieveArticles(before:String? = nil, after:String? = nil, count:Int = 20, completion: @escaping ([RRArticle]?, NSError?)-> Swift.Void) {
    
    var topEndpoint: String = "\(baseUrl)/top.json?count=\(count)"
    if let b = before {
      topEndpoint += "&before=\(b)"
    }
    if let a = after {
      topEndpoint += "&after=\(a)"
    }
    
    guard let url = URL(string: topEndpoint) else {
      print("Error: cannot create URL")
      return
    }
    let urlRequest = URLRequest(url: url)
    
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    
    let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in      
      guard error == nil else {
        print(error)
        return
      }
      
      guard let responseData = data else {
        print("Error: did not receive data")
        return
      }
      //TODO: handle errors correctly
      //TODO: remove this parsing code from the network layer
      do {
        guard let response = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
          
          print("error trying to convert data to JSON")
          return
        }
        guard let articles = response["data"]?["children"] as? [AnyObject] else {
          
          print("error retrieving data from response")
          return
        }
        var arts = [RRArticle]()
        for case let article as [String:AnyObject]  in articles{
          arts.append(RRArticle(article["data"] as! [String:AnyObject]))
        }
        completion(arts, nil)        
      } catch  {
        print("error trying to convert data to JSON")
        return
      }
      
    })
    task.resume()
  }
  
}
