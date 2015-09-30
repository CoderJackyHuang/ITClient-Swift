//
//  ArticleModel.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation

/// The item model of article.
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
class ArticleModel: NSObject {
  var aid = 0
  var author = ""
  var author_id = 0
  var date = ""
  var img = ""
  var title = ""
  
  override func valueForUndefinedKey(key: String) -> AnyObject? {
    print(key)
    return nil
  }
}