//
//  RRMainVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRMainVC: UIViewController {
  var viewModel:RRMainVM = RRMainVM(articles: [])
  
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
    refreshControl.endRefreshing()
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
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "CellPressed",
      let indexPath = tableView.indexPathForSelectedRow
    {
      let vc = segue.destination as! RRLinkVC
      vc.viewModel = self.viewModel.articleVMForCell(at: indexPath)
    }
    
    if segue.identifier == "ImagePressed",
      let button = sender as? UIButton,
      let cell = button.superview?.superview as? UITableViewCell,
      let indexPath = self.tableView.indexPath(for: cell) {
      let vc = segue.destination as! RRImageVC
      vc.viewModel = self.viewModel.articleVMForCell(at: indexPath)
    }
  }
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{
    if identifier == "ImagePressed",
      let button = sender as? UIButton,
      let cell = button.superview?.superview as? UITableViewCell,
      let indexPath = self.tableView.indexPath(for: cell),
      self.viewModel.articleVMForCell(at: indexPath).numberOfImages() <= 0{      
      return false
    }
    
    return true
  }
  
  // MARK: - Restoration
  
  override func encodeRestorableState(with coder: NSCoder) {
    super.encodeRestorableState(with: coder)
    coder.encode(viewModel,forKey:"viewModel")
    coder.encode(tableView.indexPathsForVisibleRows?[0],forKey:"indexPath")
  }
  
  override func decodeRestorableState(with coder: NSCoder) {
    super.decodeRestorableState(with: coder)
    if let vm = coder.decodeObject(forKey: "viewModel") as? RRMainVM {
      removeObserver(self, forKeyPath: #keyPath(viewModel.articles))
      self.viewModel = vm
      setupViews()
      setupObservers()
      DispatchQueue.main.async{
        self.tableView.reloadData()
      }
      if let indexPath = coder.decodeObject(forKey: "indexPath") as? IndexPath {
        DispatchQueue.main.async{
          self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
      }
    }
  }  
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
      
      cell.viewModel = viewModel.articleVMForCell(at: indexPath)
      cell.setup()
      return cell
    }
  }
}
