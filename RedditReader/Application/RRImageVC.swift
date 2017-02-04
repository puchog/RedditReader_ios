//
//  RRImageVC.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/3/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

class RRImageVC: UIViewController {
  
  var viewModel:RRArticleVM?
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let viewModel = self.viewModel else{
      print("Missing ArticleVM" )
      return
    }
    imageView.imageFromServerURL(urlString: viewModel.imageUrl(at: 0))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()    
  }
  
  @IBAction func closeBtnPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveBtnPressed(_ sender: Any) {
    
    guard let image = imageView.image else {
      let ac = UIAlertController(title: "Save error", message: "Nothing to Save", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
      return
    }
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    } else {
      let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default))
      present(ac, animated: true)
    }
  }
  
  // MARK: - Restoration
  
  override func encodeRestorableState(with coder: NSCoder) {
    super.encodeRestorableState(with: coder)
    coder.encode(viewModel,forKey:"viewModel")
  }
  
  override func decodeRestorableState(with coder: NSCoder) {
    super.decodeRestorableState(with: coder)
    if let vm = coder.decodeObject(forKey: "viewModel") as? RRArticleVM {
      self.viewModel = vm
    }
  }
}
