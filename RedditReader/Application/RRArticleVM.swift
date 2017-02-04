//
//  RRArticleVM.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/3/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRArticleVM: NSObject,NSCoding {
  let article: RRArticle
  
  // MARK: - NSCoding
  
  required convenience init?(coder decoder: NSCoder) {
    guard let article = decoder.decodeObject(forKey: "article") as? RRArticle
      else { return nil }
    self.init(article: article)
  }
  
  func encode(with aCoder: NSCoder){
    aCoder.encode(article, forKey: "article")
  }
  
  // MARK: - ViewModel
  
  init(article: RRArticle) {
    self.article = article
  }
  
  func title() -> String {
    return article.title ?? ""
  }
  
  func thumbnailUrlString() -> String {
    return article.thumbnail ?? ""
  }
  
  func infoString() -> String {
    let timeString = article.created?.timeAgo() ?? ""
    return "submitted \(timeString) by \(article.author ?? "unknown") "
  }
  
  func bottomInfoString() -> String {
    return "\(article.numComments ?? 0) comments, posted on \(article.subreddit ?? "unknown") "
  }
  
  func linkUrl() -> URL?{
    let url = try? article.url?.convertHtmlSymbols() ?? ""
    return URL(string:url!)
  }
  
  func domain() -> String{
    return article.domain ?? ""
  }
  
  func imageUrl(at index:Int)-> String{
    guard index < article.images.count else {
      return ""
    }
    return try! article.images[index].convertHtmlSymbols() ?? ""
  }
  
  func numberOfImages()-> Int{
    return article.images.count
  }
}
