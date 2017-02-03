//
//  UIButton+RRAdditions.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/3/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

extension UIButton {
  public func imageFromServerURL(urlString: String) {
    self.setImage( UIImage(named: "missing_image"), for: .normal)
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
      
      if error != nil {
        return
      }
      DispatchQueue.main.async(execute: { () -> Void in
        let image = UIImage(data: data!)
        self.setImage(image, for: .normal)
      })
      
    }).resume()
  }}
