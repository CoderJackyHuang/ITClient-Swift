//
//  Array+HYBExtension.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation

public extension Array {
  ///  更安全地获取元素
  ///
  ///  - parameter index: 索引
  ///
  ///  - returns: 如果索引正确，返回对应的元素，否则返回nil
  public func hyb_safeElement(atIndex index: Int) ->Element? {
    if index < 0 || index > self.count {
      return nil
    }
    
    let array = self
    
    return array[index]
  }
}