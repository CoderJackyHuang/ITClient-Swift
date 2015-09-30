//
//  ArticleCell.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {
  var articleModel: ArticleModel? {
    didSet {
      self.titleLabel.text = self.articleModel?.title
      if self.articleModel != nil {
        self.imgView.hyb_setImageUrl(self.articleModel!.img, holder: "icon")
      }
    }
  }
  
  // MARK: Private
  var titleLabel = UILabel()
  var imgView = UIImageView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.titleLabel.numberOfLines = 2
    self.titleLabel.textAlignment = .Left
    self.contentView.addSubview(self.titleLabel)
    self.titleLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.width.equalTo(App.screenWidth - 110)
      make.top.equalTo(10)
    }
    self.titleLabel.sizeToFit()
    
    self.contentView.addSubview(self.imgView)
    self.imgView.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.titleLabel.snp_right)
      make.right.equalTo(-10)
      make.top.equalTo(10)
      make.height.equalTo(80)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}