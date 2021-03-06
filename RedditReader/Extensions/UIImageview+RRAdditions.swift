//
//  UIImageview+AsyncDownload.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/2/17.
//  Copyright © 2017 Puchog. All rights reserved.
//

import UIKit

extension UIImageView {
  public func imageFromServerURL(urlString: String) {
    
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
      
      if error != nil {
        print(error)
        return
      }
      DispatchQueue.main.async(execute: { () -> Void in
        let image = UIImage(data: data!)
        self.image = image
      })
      
    }).resume()
  }}
