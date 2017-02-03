//
//  RRMainVM.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRMainVM: NSObject {
  
  private let network = RRNetworkCalls.sharedInstance
  
  dynamic var articles:[RRArticle] = []
  
  func refreshData(){
    network.retrieveArticles(){ (articles, error) in
      if let art = articles {
        self.articles = art
      }
    }
  }
  
  func loadMore(){
    guard !articles.isEmpty else {
      refreshData()
      return
    }
    let after = articles.last?.name ?? ""
    network.retrieveArticles(after:after){ (articles, error) in
      if let art = articles {
        self.articles += art
      }
    }
  }
  
  func titleForRow(at indexPath:IndexPath) -> String {
    return articles[indexPath.row].title ?? ""
  }
  
  func thumbnailUrlStringForRow(at indexPath:IndexPath) -> String {
    return articles[indexPath.row].thumbnail ?? ""
  }
  
  func infoStringForRow(at indexPath:IndexPath) -> String {
    let timeString = articles[indexPath.row].created?.timeAgo() ?? ""
    return "submitted \(timeString) by \(articles[indexPath.row].author ?? "unknown") "
  }
  
  func bottomInfoStringForRow(at indexPath:IndexPath) -> String {
    return "\(articles[indexPath.row].numComments ?? 0) comments, posted on \(articles[indexPath.row].subreddit ?? "unknown") "
  }
  
  func imageUrlForRow(at indexPath:IndexPath) -> String{
    let url = articles[indexPath.row].url ?? ""
    return try! url.convertHtmlSymbols() ?? ""
  }
  
  func domainForRow(at indexPath:IndexPath) -> String{
    return articles[indexPath.row].domain ?? ""
  }
  
}
