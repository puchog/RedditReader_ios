//
//  RRMainVM.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRMainVM: NSObject, NSCoding {
  
  private let network = RRNetworkCalls.sharedInstance
  dynamic var articles:[RRArticle] = []
  dynamic var currentError:String = ""
  
  // MARK: - NSCoding
  
  required convenience init?(coder decoder: NSCoder) {
    guard let articles = decoder.decodeObject(forKey: "articles") as? [RRArticle]
      else { return nil }
    self.init(articles: articles)
  }
  
  func encode(with aCoder: NSCoder){
    aCoder.encode(articles, forKey: "articles")
  }
  
  // MARK: - ViewModel
  
  init(articles: [RRArticle]){
    self.articles = articles
  }
  
  func refreshData(){
    network.retrieveArticles(){ (articles, error) in
      if let e = error{
        self.currentError = e.localizedDescription
        return
      }
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
      if let e = error{
        self.currentError = e.localizedDescription
        return
      }
      if let art = articles {
        self.articles += art
      }
    }
  }
  
  func articleVMForCell(at indexPath:IndexPath) -> RRArticleVM {
    let vm = RRArticleVM(article: articles[indexPath.row])    
    return vm
  }
  
}
