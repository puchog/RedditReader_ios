//
//  RRArticle.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRArticle: NSObject {
  var title:String?
  var author:String?
  var created:Int?
  var thumbnail:String?
  var numComments:Int?
  
  init(_ json:[String: AnyObject]) {
    title = json["title"] as? String
  }
}