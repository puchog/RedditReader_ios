//
//  RRLoadingTVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRLoadingTVC: UITableViewCell {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func startAnimating(){
    self.activityIndicator.startAnimating()
  }
  
}
