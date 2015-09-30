//
//  UserManager.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation

/// The manager of login user information.
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
class UserManager: NSObject {
  /// Singleton
  static let sharedInstance: UserManager = UserManager()
  
  /// Third party login user id
  var userClientId: Int {
    let uid = NSUserDefaults.standardUserDefaults().objectForKey("user_client_id_key")
    if let userid = uid as? Int {
      return userid
    }
    
    return 0
  }
  
  /// User nick name
  var nickname: String {
    let name = NSUserDefaults.standardUserDefaults().objectForKey("user_nickname_key")
    
    if let username = name as? String {
      return username
    }
    
    return ""
  }
  
  /// User's face, means user's head image url
  var face: String {
    let face = NSUserDefaults.standardUserDefaults().objectForKey("face_key")
    
    if let userface = face as? String {
      return userface
    }
    
    return ""
  }
  
  /// 0-qq, 1-weibo
  var platformId: Int? {
    let pid = NSUserDefaults.standardUserDefaults().objectForKey("platform_id_key")
    
    if let platform_id = pid as? Int {
      return platform_id
    }
    
    return nil
  }
  
  ///  When logined, store the information of login user.
  ///
  ///  - parameter people: Login user information
  func store(people: [String: AnyObject]) {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    defaults.setObject(people["platform_id"], forKey: "platform_id_key")
    defaults.setObject(people["face"], forKey: "face_key")
    defaults.setObject(people["nickname"], forKey: "user_nickname_key")
    defaults.setObject(people["user_client_id"], forKey: "user_client_id_key")
    
    defaults.synchronize()
  }
  
  ///  When user log out, we should call it to clear user data.
  func clear() {
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.removeObjectForKey("platform_id_key")
    defaults.removeObjectForKey("face_key")
    defaults.removeObjectForKey("user_nickname_key")
    defaults.removeObjectForKey("user_client_id_key")
    
    defaults.synchronize()
  }
}
