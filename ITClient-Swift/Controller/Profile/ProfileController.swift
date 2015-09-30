//
//  ProfileController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SwiftExtensionCodes
import MessageUI

/// My Profile
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
class ProfileController: BaseController, MFMailComposeViewControllerDelegate {
  private var tableView: UITableView!
  private var dataSource: [[String]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hyb_navWithTitle("我的江湖")
    
    self.tableView = createTableView(.Grouped)
    self.tableView.separatorStyle = .SingleLine
    
    self.dataSource.append(["我的账号", "我的收藏"])
    self.dataSource.append(["我去好评", "我去吐槽"])
    self.dataSource.append(["关注我们", "关于我们"])
  }
  
  // MARK: UITableViewDataSource
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
    
    if cell == nil {
      cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
    }
    
    var found = false
    if indexPath.section == 0 && indexPath.row == 0 {
      // log in
      if UserManager.sharedInstance.userClientId != 0 {
        cell?.imageView?.hyb_setImageUrl(UserManager.sharedInstance.face)
        cell?.textLabel?.text = UserManager.sharedInstance.nickname
        found = true
      }
    }
    
    if !found {
      cell?.textLabel?.text = self.dataSource[indexPath.section][indexPath.row]
      cell?.imageView?.image = nil
    }
    return cell!
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.dataSource.count
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource[section].count
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    switch indexPath.section {
    case 0:
      if indexPath.row == 0 {
        LoginController.showInController(self, success: { () -> Void in
         tableView.reloadData()
        })
      }
    case 1:
      if indexPath.row == 0 {// To evaluate
        let url = "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=946717730&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
      } else {// To send email
        self.sendEmail(["huangyibiao520@163.com"], subject: "我要吐槽")
      }
    default:
      let controller = indexPath.row == 0 ? FollowUsController() : AboutUsController()
      self.navigationController?.pushViewController(controller, animated: true)
    }
  }
  
  // MARK: MFMailComposeViewControllerDelegate
  func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
  
  // MARK: Private
  private func sendEmail(receiver: [String], subject: String, isHTML: Bool = false) {
    let mail = MFMailComposeViewController()
    mail.mailComposeDelegate = self // set delegate
    
    // set the email receiver
    mail.setToRecipients(receiver)
    // set the subject of email
    mail.setSubject(subject)
    // set the body of email
    let info:Dictionary = NSBundle.mainBundle().infoDictionary!
    let appName = info["CFBundleName"] as! String
    let appVersion = info["CFBundleVersion"] as! String
    mail.setMessageBody("</br></br></br></br></br>基本信息：</br></br>AppName:\(appName)</br>DeviceName: \(UIDevice.currentDevice().name)</br>DeviceVersion: iOS \(UIDevice.currentDevice().systemVersion) </br>AppVersion: \(appVersion)", isHTML: true)
    
    if MFMailComposeViewController.canSendMail() {
      dispatch_async(App.mainQueue, { () -> Void in
        self.presentViewController(mail, animated: true, completion: nil)
      })
    }
  }
}