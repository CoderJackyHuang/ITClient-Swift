//
//  BaseController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/// The base controller, for any view controller exclude navigation controller.
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
class BaseController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.edgesForExtendedLayout = .None
  }
  ///  创建tableview，默认为Plain样式，默认约束为self.view点满
  ///
  ///  - parameter style:      样式，默认为Plain
  ///  - parameter constraint: 约束，默认为self.view.edges
  ///
  ///  - returns: tableView对象
  func createTableView(style: UITableViewStyle = .Plain, constraint: ((make: ConstraintMaker) -> Void)? = nil) ->UITableView {
    let tableView = UITableView(frame: CGRectZero, style: style)
    tableView.delegate = self
    tableView.dataSource = self
    self.view.addSubview(tableView)
    
    tableView.separatorStyle = .None
    tableView.sectionIndexBackgroundColor = UIColor.blackColor()
    tableView.sectionIndexTrackingBackgroundColor = UIColor.darkGrayColor()
    tableView.sectionIndexColor = UIColor.whiteColor()
    
    if constraint != nil {
      tableView.snp_makeConstraints(closure: constraint!)
    } else {
      tableView.snp_makeConstraints(closure: { (make) -> Void in
        make.edges.equalTo(self.view)
      })
    }
    
    return tableView
  }
  
  // MARK: UITableViewDataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
