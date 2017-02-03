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
  
  
  
  func articleVMForCell(at indexPath:IndexPath) -> RRArticleVM {
    let vm = RRArticleVM(article: articles[indexPath.row])    
    return vm
  }
  
}
