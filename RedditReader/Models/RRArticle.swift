//
//  RRArticle.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRArticle: NSObject {
  
  var name:String?
  var title:String?
  var author:String?
  var created:NSDate?
  var thumbnail:String?
  var numComments:Int?
  
  init(_ json:[String: AnyObject]) {
    title = json["title"] as? String
    thumbnail = json["thumbnail"] as? String
    let createdDouble = json["created"] as? Double
    created =  NSDate(timeIntervalSince1970: createdDouble ?? 0.0 )
    author = json["author"] as? String
    numComments = json["num_comments"] as? Int
    name = json["name"] as? String
  }
}
