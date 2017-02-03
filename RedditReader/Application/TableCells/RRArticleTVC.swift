//
//  RRArticleTVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRArticleTVC: UITableViewCell {
  
  var viewModel:RRArticleVM?
  
  @IBOutlet weak var imageBtn: UIButton!
  @IBOutlet weak var titleLbl: UILabel!
  @IBOutlet weak var infoLbl: UILabel!
  @IBOutlet weak var bottomInfoLbl: UILabel!  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageBtn.imageView?.contentMode = UIViewContentMode.scaleAspectFill
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
   
  }
  
  func setup(){
    guard let viewModel = self.viewModel else {
      print("Missing Article ViewModel")
      return
    }
    self.titleLbl.text = viewModel.title()
    self.imageBtn.imageFromServerURL(urlString: viewModel.thumbnailUrlString())
    self.infoLbl.text = viewModel.infoString()
    self.bottomInfoLbl.text = viewModel.bottomInfoString()
  }
  
}
