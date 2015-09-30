//
//  UIViewController+HYBExtension.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/25.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

public enum AlertOKCancelDirection: Int {
  case OkCancel
  case CancelOk
}

private var sg_hyb_alert_actionsheet_controller: UIAlertController?
private var sg_default_ok_button_title = "确定"
private var sg_default_cancel_button_title = "取消"
private var sg_ok_cancel_button_direction = AlertOKCancelDirection.CancelOk

/// UIViewController extension for AlertView and ActionSheet
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
public extension UIViewController {
  /// Get/Set the default ok button title
  public var hyb_defaultOkTitle: String {
    get { return sg_default_ok_button_title }
    set { sg_default_ok_button_title = newValue }
  }
  
  /// Get/Set the default cance button title
  public var hyb_defaultCancelTitle: String {
    get { return sg_default_cancel_button_title }
    set { sg_default_cancel_button_title = newValue }
  }
  
  /// Get/Set the defaul direction between ok button and cancel button. Default is CacelOk.
  public var hyb_okCancelDirection: AlertOKCancelDirection {
    get { return sg_ok_cancel_button_direction }
    set { sg_ok_cancel_button_direction = newValue }
  }
  
  // MARK: Ok Alert
  
  ///  Only Show Alert View in current controller
  ///
  ///  - parameter title: title
  public func hyb_showOkAlert(title: String?) {
    self.hyb_showOkAlert(title, message: nil)
  }
  
  ///  Show Alert view in current controller with a ok button
  ///
  ///  - parameter title:   alert view's title
  ///  - parameter message: show the message
  public func hyb_showOkAlert(title: String?, message: String?) {
    self.hyb_showAlertActionSheet(title, message: nil, preferredStyle: .Alert, alertActions: [UIAlertAction(title: self.hyb_defaultOkTitle, style: .Default, handler: { (e) -> Void in
      sg_hyb_alert_actionsheet_controller = nil
    })])
  }
  
  ///  Show title and an ok button of Alert
  ///
  ///  - parameter title: alert's title
  ///  - parameter ok:    ok button call back
  public func hyb_showOkAlert(title: String?, ok: () ->Void) {
    self.hyb_showAlertActionSheet(title, message: nil, preferredStyle: .Alert, alertActions: [UIAlertAction(title: self.hyb_defaultOkTitle, style: .Default, handler: { (e) -> Void in
      sg_hyb_alert_actionsheet_controller = nil
      ok()
    })])
  }
  
  ///  Show title, message and an ok button of Alert
  ///
  ///  - parameter title:   title
  ///  - parameter message: message
  ///  - parameter ok:      ok button call back
  public func hyb_showOkAlert(title: String?, message: String?, ok: () ->Void) {
    self.hyb_showAlertActionSheet(title, message: message, preferredStyle: .Alert, alertActions: [UIAlertAction(title: self.hyb_defaultOkTitle, style: .Default, handler: { (e) -> Void in
      sg_hyb_alert_actionsheet_controller = nil
      ok()
    })])
  }
  
  // MARK: Cancel Alert
  ///  Only Show Alert View in current controller
  ///
  ///  - parameter title: title
  public func hyb_showCancelAlert(title: String?) {
    self.hyb_showCancelAlert(title, message: nil)
  }
  
  ///  Show Alert view in current controller with a cancel button
  ///
  ///  - parameter title:   alert view's title
  ///  - parameter message: show the message
  public func hyb_showCancelAlert(title: String?, message: String?) {
    self.hyb_showAlertActionSheet(title, message: nil, preferredStyle: .Alert, alertActions: [UIAlertAction(title: self.hyb_defaultCancelTitle, style: .Default, handler: { (e) -> Void in
      sg_hyb_alert_actionsheet_controller = nil
    })])
  }
  
  ///  Show title and an ok button of Alert
  ///
  ///  - parameter title:  alert's title
  ///  - parameter cancel: cancel button call back
  public func hyb_showCancelAlert(title: String?, cancel: () ->Void) {
    self.hyb_showAlertActionSheet(title, message: nil, preferredStyle: .Alert, alertActions: [UIAlertAction(title: self.hyb_defaultCancelTitle, style: .Default, handler: { (e) -> Void in
      sg_hyb_alert_actionsheet_controller = nil
      cancel()
    })])
  }
  
  ///  Show title, message and an ok button of Alert
  ///
  ///  - parameter title:   title
  ///  - parameter message: message
  ///  - parameter cancel:  cancel button call back
  public func hyb_showCancelAlert(title: String?, message: String?, cancel: () ->Void) {
    self.hyb_showAlertActionSheet(title, message: message, preferredStyle: .Alert, alertActions: [UIAlertAction(title: self.hyb_defaultCancelTitle, style: .Default, handler: { (e) -> Void in
      sg_hyb_alert_actionsheet_controller = nil
      cancel()
    })])
  }

  // MARK: Ok And Cancel Alert
  
  ///  Show Ok and cancel alert view
  ///
  ///  - parameter title: title
  public func hyb_showAlert(title: String?) {
    self.hyb_showAlert(title, message: nil)
  }
  
  ///  Show Ok and cancel alert view with title and message
  ///
  ///  - parameter title:   title
  ///  - parameter message: message
  public func hyb_showAlert(title: String?, message: String?) {
    var buttonTitles: [String]!
    
    if self.hyb_okCancelDirection == .OkCancel {
      buttonTitles = [self.hyb_defaultOkTitle, self.hyb_defaultCancelTitle]
    } else {
      buttonTitles = [self.hyb_defaultCancelTitle, self.hyb_defaultOkTitle]
    }
    
    self.hyb_showAlert(title, message: message, buttonTitles: buttonTitles) { (index) -> Void in
    sg_hyb_alert_actionsheet_controller = nil
    }
  }
  
  ///  Show alert view with title, message and custom button titles.
  ///
  ///  - parameter title:         title
  ///  - parameter message:       message
  ///  - parameter buttonTitles:  custom button titles
  ///  - parameter buttonClosure: call back
  public func hyb_showAlert(title: String?, message: String?, buttonTitles: [String]?, buttonClosure: ((index: Int) ->Void)?) {
    var buttonArray: [UIAlertAction]?
    if let titles = buttonTitles {
      for (index, item) in titles.enumerate() {
        buttonArray?.append(UIAlertAction(title: item, style: .Default, handler: { (e) -> Void in
          if let callback = buttonClosure {
            sg_hyb_alert_actionsheet_controller = nil
            callback(index: index)
          }
        }))
      }
    }
    
    self.hyb_showAlertActionSheet(title, message: message, preferredStyle: .Alert, alertActions: buttonArray)
  }
  
  // MARK: Private

  private func hyb_showAlertActionSheet(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, alertActions: [UIAlertAction]?) {
    // prevent show too many times
    guard let _ = sg_hyb_alert_actionsheet_controller else {
      return
    }
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    
    if let actions = alertActions {
      for alertAction in actions {
        alertController.addAction(alertAction)
      }
    }
    
    sg_hyb_alert_actionsheet_controller = alertController
    self.presentViewController(alertController, animated: true, completion: nil)
  }
}