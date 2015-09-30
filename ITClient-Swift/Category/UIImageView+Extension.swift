//
//  UIImageView+Extension.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {
  func hyb_setImageUrl(url: String) {
    self.af_setImageWithURL(NSURL(string: url)!, placeholderImage: nil)
  }
  
  func hyb_setImageUrl(url: String, holder: String) {
    self.af_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: holder))
  }
}
