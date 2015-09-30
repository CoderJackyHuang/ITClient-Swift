//
//  RootTabBarController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import HYBViewControllerCategory

/// App Entrance
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
class RootTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.viewControllers = [
      nav("首页", image: "tab_home_icon", type: 0),
      nav("技术", image: "js", type: 1),
      nav("趣文", image: "qw", type: 2),
      nav("我的江湖", image: "user", type: 3)
    ]
  }
  
  private func nav(title: String, image: String, type: Int = 0) ->AppNavigationController {
    var controller: BaseController
    
    switch type {
    case 0:
      controller = HomeController()
    case 1:
      controller = TechnologyController()
    case 2:
      controller = InterestingController()
    default:
      controller = ProfileController()
    }
    
    let nav = AppNavigationController(rootViewController: controller)
    nav.hyb_setTabBarItemWithTitle(title,
      selectedImage: nil,
      unSelectedImage: image,
      imageMode: UIImageRenderingMode.AlwaysOriginal,
      selectedTextColor: UIColor.blueColor(),
      unSelectedTextColor: nil)
    
    return nav
  }
}