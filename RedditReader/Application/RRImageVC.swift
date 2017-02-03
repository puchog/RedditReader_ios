//
//  RRImageVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/3/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit
import WebKit

class RRImageVC: UIViewController, WKNavigationDelegate {
  
  var webView: WKWebView!
  var imageUrl:String?
  var domain:String?
  
  override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
    view = webView
    
    if let iurl = imageUrl, let url = URL(string: iurl) {     
      webView.load(URLRequest(url: url))
      webView.allowsBackForwardNavigationGestures = true
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
