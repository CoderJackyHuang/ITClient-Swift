//
//  RefreshTableController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

protocol RefreshProtocol {
  func refreshCallback(isLoadMore: Bool)
}

/// Support pull down to refresh and pull up to load more.
class RefreshTableController: BaseController, RefreshProtocol {
  var tableView: UITableView!
  var currentIndex = 0
  var pageSize = 10
  
  private var isLoading = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView = createTableView()
    self.tableView.header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
      if self.isLoading {
        return
      }
      
      self.currentIndex = 1
      self.isLoading = true
      self.refreshCallback(false)
    })
    
    let footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
      if self.isLoading {
        return
      }
      
      self.currentIndex++
      self.isLoading = true
      self.refreshCallback(true)
    })

    self.tableView.footer = footer
  }
  
  func refreshCallback(isLoadMore: Bool) {
    // Subclass should override this method and call super.refreshCallback
  }
  
  func endRefresh(isLoadMore: Bool = false, noMore: Bool = false) {
    self.isLoading = false
    
    if !isLoadMore {
      self.tableView.footer.resetNoMoreData()
      self.tableView.header.endRefreshing()
    } else {
      if noMore {
        self.tableView.footer.noticeNoMoreData()
      } else {
        self.tableView.footer.resetNoMoreData()
      }
      
      self.tableView.footer.endRefreshing()
    }
  }
}