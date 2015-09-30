//
//  App.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

/// 系统App全局使用的常量、API等。不用实例化。
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
struct App {
  // MARK: IOS Version
  
  /// Return true if ios version is >= 7
  static var isIOS7: Bool {
    return Int(self.iosVersion) >= 7
  }
  
  /// Return true if ios version is >= 8
  static var isIOS8: Bool {
    return Int(self.iosVersion) >= 8
  }
  
  /// Return true if ios version is >= 9
  static var isIOS9: Bool {
    return Int(self.iosVersion) >= 9
  }
  
  /// Return ios version
  static var iosVersion: String {
    return UIDevice.currentDevice().systemVersion
  }
  
  // MARK: Device
  
  /// Get the screen's width
  static var screenWidth: CGFloat {
    return UIScreen.mainScreen().bounds.width
  }
  
  /// Get the screen's height
  static var screenHeight: CGFloat {
    return UIScreen.mainScreen().bounds.height
  }
  
  /// Get the screen's bounds
  static var screenBounds: CGRect {
    return UIScreen.mainScreen().bounds
  }
  
  // MARK: GCD
  
  /// Get main queue
  static var mainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
  }
  
  /// Get default global queue
  static var globalQueue: dispatch_queue_t {
    return dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
  }
}
