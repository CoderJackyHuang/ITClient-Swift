//
//  FollowUsController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

/// Follow us
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
class FollowUsController: BaseController {
  private var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hyb_navWithTitle("关注我们")
    self.tableView = createTableView()
    
    let headerView = UIView()
    
    let imageView = UIImageView(image: UIImage(named: "blog"))
    headerView.addSubview(imageView)
    imageView.sizeToFit()
    imageView.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(headerView)
      make.centerY.equalTo(headerView).offset(-100)
      make.size.lessThanOrEqualTo(CGSizeMake(self.view.hyb_width - 40, self.view.hyb_width - 40))
    }
    
    let tipLabel = UILabel()
    tipLabel.text = "博客：http://www.hybblog.com/\n微博：JackyHuang标哥\nGithub:http://github.com/CoderJackyHuang/"
    tipLabel.numberOfLines = 0
    tipLabel.textAlignment = .Left
    tipLabel.textColor = UIColor.blueColor()
    headerView.addSubview(tipLabel)
    tipLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10)
      make.right.equalTo(-10)
      make.top.equalTo(imageView.snp_bottom).offset(10)
    }
    
    self.tableView.tableHeaderView = headerView
    headerView.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(self.view.hyb_height)
      make.width.equalTo(self.view.hyb_width)
    }
  }
}