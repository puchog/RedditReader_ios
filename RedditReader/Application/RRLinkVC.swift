//
//  RRLinkVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/3/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit
import WebKit

class RRLinkVC: UIViewController , WKNavigationDelegate {
  
  var viewModel:RRArticleVM?
  
  var webView: WKWebView!
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
    view = webView
    
    guard let viewModel = self.viewModel else{
      print("Missing ArticleVM" )
      return
    }
    
    if let url = viewModel.linkUrl() {
      webView.load(URLRequest(url: url))
      webView.allowsBackForwardNavigationGestures = true
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
