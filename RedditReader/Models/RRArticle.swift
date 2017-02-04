//
//  RRArticle.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRArticle: NSObject,NSCoding {
  
  var name:String?
  var title:String?
  var author:String?
  var created:NSDate?
  var thumbnail:String?
  var numComments:Int?
  var domain:String?
  var subreddit:String?
  var url:String?
  
  var images:[String]=[]
  
  override init() {
    super.init()
  }
  
  init(_ json:[String: AnyObject]) {
    title = json["title"] as? String
    thumbnail = json["thumbnail"] as? String
    
    let createdDouble = json["created"] as? Double
    
    created =  NSDate(timeIntervalSince1970: createdDouble ?? 0.0 )
    author = json["author"] as? String
    numComments = json["num_comments"] as? Int
    name = json["name"] as? String
    domain = json["domain"] as? String
    subreddit = json["subreddit"] as? String
    url = json["url"] as? String
    
    if let preview = json["preview"] as? [String: AnyObject],
      let images = preview["images"] as? [AnyObject] {
      self.images = []
      for case let image as [String:AnyObject]  in images{
        if let source = image["source"] as? [String: AnyObject] {
          self.images.append(source["url"] as! String)
        }
      }
    }
    
  }
  
  // MARK: - NSCoding
  
  required convenience init(coder decoder: NSCoder) {
    self.init()
    name = decoder.decodeObject(forKey: "name") as? String
    title = decoder.decodeObject(forKey: "title") as? String
    author = decoder.decodeObject(forKey: "author") as? String
    created = decoder.decodeObject(forKey: "created") as? NSDate
    thumbnail = decoder.decodeObject(forKey: "thumbnail") as? String
    numComments = decoder.decodeObject(forKey: "numComments") as? Int
    domain = decoder.decodeObject(forKey: "domain") as? String
    subreddit = decoder.decodeObject(forKey: "subreddit") as? String
    url = decoder.decodeObject(forKey: "url") as? String
  }
  
  func encode(with aCoder: NSCoder){
    aCoder.encode(name, forKey: "name")
    aCoder.encode(title, forKey: "title")
    aCoder.encode(author, forKey: "author")
    aCoder.encode(created, forKey: "created")
    aCoder.encode(thumbnail, forKey: "thumbnail")
    aCoder.encode(numComments, forKey: "numComments")
    aCoder.encode(domain, forKey: "domain")
    aCoder.encode(subreddit, forKey: "subreddit")
    aCoder.encode(url, forKey: "url")
  }

}
