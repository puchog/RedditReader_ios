//
//  RRMainVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRMainVC: UIViewController {
  let viewModel:RRMainVM = RRMainVM()
  
  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
   
    viewModel.refreshData()
    setupViews()
    setupObservers()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  deinit {
    removeObserver(self, forKeyPath: #keyPath(viewModel.articles))
  }
 
  
  private func setupViews(){
    
  }
  
  private func setupObservers(){    
    addObserver(self, forKeyPath: #keyPath(viewModel.articles), options: [.old, .new], context: nil)
  }
  
  // MARK: - Key-Value Observing
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == #keyPath(viewModel.articles) {
      // Reload TableView Data
      tableView.reloadData()
    }
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

extension RRMainVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cellIdentifier = "ArticleCell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RRArticleTVC
      ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier) as! RRArticleTVC
    
    cell.setup(with: viewModel, indexPath: indexPath)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
