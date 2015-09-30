//
//  ArticleDetailController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/28.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class ArticleDetailController: BaseController {
  private var model: ArticleModel?
  private var webView = UIWebView()
  private var toolbar = UIToolbar()
  
  init(articleModel: ArticleModel) {
    self.model = articleModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hyb_navWithTitle("文章详情")
    
    self.view.addSubview(self.toolbar)
    self.toolbar.snp_makeConstraints { (make) -> Void in
      make.bottom.left.right.equalTo(0)
      make.height.equalTo(49)
    }
    
    self.toolbar.items = [
      UIBarButtonItem(image: UIImage(named: "back_icon"), style: UIBarButtonItemStyle.Plain, target: self, action: "backToPrevious"),
      UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
      UIBarButtonItem(image: UIImage(named: "store_icon_default"), style: UIBarButtonItemStyle.Plain, target: self, action: "storeHandler"),
      UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
      UIBarButtonItem(image: UIImage(named: "share_icon_default"), style: UIBarButtonItemStyle.Plain, target: self, action: "shareHandler")
    ]
    
    self.toolbar.userInteractionEnabled = false
    self.view.addSubview(self.webView)
    self.webView.snp_makeConstraints { (make) -> Void in
      make.left.right.top.equalTo(self.view)
      make.bottom.equalTo(self.toolbar.snp_top)
    }
    self.webView.scalesPageToFit = true
    
    SVProgressHUD.show()
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    HttpService.articleDetail("\(self.model!.aid)", success: { (html, isCollected) -> Void in
      self.webView.loadHTMLString(html, baseURL: nil)
      if isCollected {
        self.toolbar.items![2].image = UIImage(named: "store_icon_pressed")
        self.toolbar.items![2].enabled = false
      } else {
        self.toolbar.items![2].image = UIImage(named: "store_icon_default")
      }
      
      SVProgressHUD.dismiss()
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
      self.toolbar.userInteractionEnabled = true
      }) { (msg) -> Void in
        SVProgressHUD.showErrorWithStatus(msg)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.toolbar.userInteractionEnabled = true
    }
  }
  
  func storeHandler() {
    if UserManager.sharedInstance.userClientId == 0 {
      LoginController.showInController(self, success: { () -> Void in
        // login success
        self.performStoreArticle()
      })
    } else {
      self.performStoreArticle()
    }
  }
  
  func shareHandler() {
    let saimg = UIImage(data: NSData(contentsOfURL: NSURL(string: self.model!.img)!)!)
    let atitle = self.webView.stringByEvaluatingJavaScriptFromString("document.title")!
    UMSocialData.defaultData().extConfig.title = atitle
   
    let shareUrl = "http://www.itjh.com.cn/"
    UMSocialWechatHandler.setWXAppId("wxf17bc88ea6076de8",
      appSecret: "50f8da2f5a4756526b4a0b6574e2650a",
      url: shareUrl + "\(self.model!.aid).html")
    
    UMSocialDataService.defaultDataService().requestAddFollow(UMShareToSina,
      followedUsid:
      ["2937537505"],
      completion: nil)
    
    let snsArray = [
      UMShareToSina,
      UMShareToWechatSession,
      UMShareToQQ,
      UMShareToQzone,
      UMShareToWechatTimeline,
      UMShareToFacebook,
      UMShareToTwitter,
      UMShareToEmail]
    
    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      UMSocialSnsService.presentSnsIconSheetView(self,
        appKey: "54238dc5fd98c501b5028d70",
        shareText:atitle + "  " + shareUrl + "\(self.model!.aid).html",
        shareImage: saimg,
        shareToSnsNames: snsArray,
        delegate: nil)
    }
  }
  
  func backToPrevious() {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  // MARK: Private
  
  ///  Collect article
  private func performStoreArticle() {
    let parameters = [
      "user_client_id" : String(UserManager.sharedInstance.userClientId),
      "article_id" : String(self.model!.aid)
    ]
    
    SVProgressHUD.showWithStatus("Storing...")
    HttpService.store(parameters, success: { (response) -> Void in
      if let result = response["result"] as? Int {
        if result == 1 {
          self.toolbar.items![2].image = UIImage(named: "store_icon_pressed")
        }
        
        SVProgressHUD.showSuccessWithStatus(response["description"] as! String)
      }
      }) { () -> Void in
        SVProgressHUD.showErrorWithStatus("Store error!")
    }
  }
}