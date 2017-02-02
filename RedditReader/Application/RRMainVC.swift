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
  var refreshControl: UIRefreshControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupObservers()
    refreshData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  deinit {
    removeObserver(self, forKeyPath: #keyPath(viewModel.articles))
  }
  
  private func setupViews(){
    refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(refreshData), for: UIControlEvents.valueChanged)
    tableView.addSubview(refreshControl) // not required when using UITableViewController
  }
  
  private func setupObservers(){
    addObserver(self, forKeyPath: #keyPath(viewModel.articles), options: [.old, .new], context: nil)
  }
  
  func refreshData() {
    viewModel.refreshData()
  }
  
  
  
  // MARK: - Key-Value Observing
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == #keyPath(viewModel.articles) {
      // Reload TableView Data
      refreshControl.endRefreshing()
      DispatchQueue.main.async{
        self.tableView.reloadData()
      }
//      tableView.reloadData()
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
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return viewModel.articles.count
    } else {
      return 1
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let loadingCellIdentifier = "LoadingCell"
    let cellIdentifier = "ArticleCell"
    
    if indexPath.section == 1{
      let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellIdentifier) as? RRLoadingTVC
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: loadingCellIdentifier) as! RRLoadingTVC
      viewModel.loadMore()
      cell.startAnimating()
      return cell
    }else{
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? RRArticleTVC
        ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier) as! RRArticleTVC
      
      cell.setup(with: viewModel, indexPath: indexPath)
      return cell
    }
  }
}
