//
//  RRArticleTVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRArticleTVC: UITableViewCell {
  
  @IBOutlet weak var thumbnailIV: UIImageView!
  @IBOutlet weak var titleLbl: UILabel!
  @IBOutlet weak var infoLbl: UILabel!
  @IBOutlet weak var bottomInfoLbl: UILabel!  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
   
  }
  
  func setup(with viewModel:RRMainVM, indexPath:IndexPath){
    self.titleLbl.text = viewModel.titleForRow(at: indexPath)    
    self.thumbnailIV.imageFromServerURL(urlString: viewModel.thumbnailUrlStringForRow(at: indexPath))
    self.infoLbl.text = viewModel.infoStringForRow(at: indexPath)
    self.bottomInfoLbl.text = viewModel.bottomInfoStringForRow(at: indexPath)
  }
  
}
