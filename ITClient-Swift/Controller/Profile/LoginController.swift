//
//  LoginController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class LoginController: BaseController {
  private var tableView = UITableView()
  private var success: (() ->Void)?
  private var logutButton: UIButton!
  
  ///  Any where need to login, should call this api to show login view.
  ///
  ///  - parameter controller: presenting controller
  ///  - parameter success:    login success callback
  class func showInController(controller: BaseController, success: () ->Void) {
    let loginController = LoginController()
    loginController.success = success
    
    let nav = AppNavigationController(rootViewController: loginController)
    
    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      controller.presentViewController(nav, animated: true, completion: nil)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hyb_navWithLeftImage("back_icon", title: "登录") { (_) -> Void in
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    self.tableView = createTableView()
    
    let headerView = UIView()
    let logo = UIImageView(image: UIImage(named: "login_logo"))
    headerView.addSubview(logo)
    logo.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(headerView)
      make.top.equalTo(90)
    }
    logo.sizeToFit()
    
    let weiboButton = UIButton(type: .Custom)
    weiboButton.setImage(UIImage(named: "weibo_login"), forState: .Normal)
    weiboButton.sizeToFit()
    headerView.addSubview(weiboButton)
    weiboButton.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(headerView)
      make.top.equalTo(logo.snp_bottom).offset(50)
    }
    weiboButton.addTarget(self, action: "weiboLoginHandler", forControlEvents: .TouchUpInside)
    
    let qqButton = UIButton(type: .Custom)
    qqButton.setImage(UIImage(named: "qq_login"), forState: .Normal)
    qqButton.sizeToFit()
    headerView.addSubview(qqButton)
    qqButton.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(headerView)
      make.top.equalTo(weiboButton.snp_bottom).offset(10)
    }
    qqButton.addTarget(self, action: "qqLoginHandler", forControlEvents: .TouchUpInside)
    
    let logoutButton = UIButton(type: .Custom)
    logoutButton.setTitle("登出", forState: .Normal)
    logoutButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
    headerView.addSubview(logoutButton)
    logoutButton.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(qqButton)
      make.height.equalTo(qqButton)
      make.centerX.equalTo(qqButton)
      make.top.equalTo(qqButton.snp_bottom).offset(50)
    }
    
    logoutButton.hidden = UserManager.sharedInstance.userClientId == 0
    logoutButton.addTarget(self, action: "logoutHandler", forControlEvents: .TouchUpInside)
    self.logutButton = logoutButton
    
    self.tableView.tableHeaderView = headerView
    headerView.snp_makeConstraints { (make) -> Void in
      make.left.top.equalTo(0)
      make.width.equalTo(App.screenWidth)
      make.height.equalTo(App.screenHeight)
    }
  }
  
///  Log out
  func logoutHandler() {
    UserManager.sharedInstance.clear()
    
    self.logutButton.hidden = true
  }
  
  func qqLoginHandler() {
    login()
  }
  
  func weiboLoginHandler() {
    login(false)
  }
  
  private func login(isQQ: Bool = true) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    
    var snsName = UMSocialSnsPlatformManager.getSnsPlatformString(UMSocialSnsTypeMobileQQ)
    if !isQQ {
      snsName = UMSocialSnsPlatformManager.getSnsPlatformString(UMSocialSnsTypeSina)
    }
    
    let platform = UMSocialSnsPlatformManager.getSocialPlatformWithName(snsName)
    
    platform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, { (response) -> Void in
      let usm = UMSResponseCodeSuccess
      let rcode = response.responseCode
      
      if rcode.rawValue == usm.rawValue {
        let snsAccount = UMSocialAccountManager.socialAccountDictionary()
        let qqUser =  snsAccount[UMShareToQQ] as! UMSocialAccountEntity
        let usid = qqUser.usid
        let username = qqUser.userName
        let icon = qqUser.iconURL
        
        // 登录会失败，因为参数发生了变化，不知道具体要传什么参数什么值了。
        let parameters = [
          "nickname"       : username,
          "face"           : icon,
          "user_client_id" : usid,
          "platform_id"    : isQQ ? "1" : "0",
        ]
        SVProgressHUD.show()
        HttpService.login(parameters, success: { (dict) -> Void in
          SVProgressHUD.dismiss()
          
          UserManager.sharedInstance.store(dict)
          self.success?()
          
          UIApplication.sharedApplication().networkActivityIndicatorVisible = false
          self.dismissViewControllerAnimated(true, completion: nil)
          }, fail: { () -> Void in
            SVProgressHUD.showErrorWithStatus("登录失败")
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
      } else {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      }
    })
  }
}