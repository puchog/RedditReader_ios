//
//  NSString+RRAdditions.swift
//  RedditReader
//
//  Created by Juan Giannuzzo on 2/3/17.
//  Copyright © 2017 Puchog. All rights reserved.
//
import UIKit

extension String {
  
  func convertHtmlSymbols() throws -> String? {
    guard let data = data(using: .utf8) else { return nil }
    
    return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil).string
  }
}
