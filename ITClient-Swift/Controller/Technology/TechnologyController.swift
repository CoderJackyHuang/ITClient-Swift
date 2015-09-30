//
//  TechnologyController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

/// Technology
class TechnologyController: RefreshTableController {
  var category: Int {
    return 1
  }
  
  private var dataSource: [ArticleModel] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hyb_navWithTitle("技术")
    self.tableView.rowHeight = 100
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if self.dataSource.isEmpty {
      self.tableView.header.beginRefreshing()
    }
  }
  
  override func refreshCallback(isLoadMore: Bool) {
    super.refreshCallback(isLoadMore)
    
    self.requestData(isLoadMore)
  }
  
  private func requestData(isLoadMore: Bool = false) {
    HttpService.requestArticles(self.category, currentPage: self.currentIndex, pageSize: self.pageSize, success: { (articleModels) -> Void in
      if !isLoadMore {
        self.dataSource = articleModels
        self.tableView.reloadData()
        self.endRefresh(isLoadMore)
      } else {
        self.dataSource += articleModels
        self.tableView.reloadData()
        self.endRefresh(isLoadMore, noMore: articleModels.count < self.pageSize)
      }
      }) { (error) -> Void in
        SVProgressHUD.showErrorWithStatus(error)
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: ArticleCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? ArticleCell
    
    if cell == nil {
      cell = ArticleCell(style: .Default, reuseIdentifier: CellIdentifier)
      self.tableView.separatorStyle = .SingleLine
    }
    
    cell?.articleModel = self.dataSource[indexPath.row]
    
    return cell!
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let model = self.dataSource[indexPath.row]
    
    let controller = ArticleDetailController(articleModel: model)
    self.navigationController?.pushViewController(controller, animated: true)
  }
}