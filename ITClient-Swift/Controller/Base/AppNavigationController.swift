//
//  AppNavigationController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

/// Any where when use a navigation controller, just use AppNavigationController,
/// don't use UINavigationController directly.
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
class AppNavigationController: UINavigationController {
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hyb_configNavBarWithBackImage(nil,
      shadowImage: nil,
      tintColor: self.navigationBar.tintColor,
      barTintColor: self.navigationBar.barTintColor,
      titleColor: UIColor.blackColor(),
      titleFont: UIFont.systemFontOfSize(17),
      hideBackTitle: true)
  }
  
  override func pushViewController(viewController: UIViewController, animated: Bool) {
    if self.viewControllers.count > 0 {
      viewController.hidesBottomBarWhenPushed = true
    }
    
    super.pushViewController(viewController, animated: animated)
  }
}
