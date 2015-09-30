//
//  HttpService.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import Alamofire

/// Http Api service manager
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
struct HttpService {
  ///  articles api.
  ///
  ///  - parameter category:    Api type, 1 means technology, 2 means interesting, 0 means home
  ///  - parameter currentPage: current page index
  ///  - parameter pageSize:    how many items to show
  ///  - parameter success:     success callback closure
  ///  - parameter fail:        failure callback closure
  ///
  ///  - returns: the request object, with it, we can cancel a request, etc.
  static func requestArticles(category: Int = 0, currentPage: Int, pageSize: Int,
    success: ((articleModels: [ArticleModel]) ->Void)?,
    fail: ((error: String) ->Void)? = nil) ->Request {
      var url = ""
      switch category {
      case 0:
        url = HttpURL.homeUrl(currentPage, pageSize: pageSize)
      case 1:
        url = HttpURL.technologyUrl(currentPage, pageSize: pageSize)
      default:
        url = HttpURL.interestUrl(currentPage, pageSize: pageSize)
      }
      
      let req = Manager.sharedInstance.request(.GET, url)
      
      req.responseJSON { (request, response, object) -> Void in
        if object.isSuccess {
          var models: [ArticleModel] = []
          
          if let value = object.value as? [String: AnyObject], let content = value["content"] as? NSArray {
            for item in content {
              if let itemObject = item as? [String: AnyObject] {
                let itemModel = ArticleModel()
                itemModel.setValuesForKeysWithDictionary(itemObject)
                
                models.append(itemModel)
              }
            }
          }
          
          success?(articleModels: models)
        } else {
          fail?(error: object.error.debugDescription)
        }
      }
      
      return req
  }
  
  ///  Get article detail
  ///
  ///  - parameter articleId: article id
  ///  - parameter userId:    login user id if have logined
  ///  - parameter success:   success callback
  ///  - parameter fail:      fail callback
  ///
  ///  - returns: Request object.
  static func articleDetail(articleId: String, userId: String = "", success: (String, Bool) ->Void, fail: (String) ->Void) ->Request {
    let request = Manager.sharedInstance.request(.GET, HttpURL.articleUrl(articleId, userId: userId))
    
    request.responseJSON { (_, _, result) -> Void in
      if result.isSuccess {
        let data = result.value! as! [String: AnyObject]
        
        let articles = data["content"] as! [String: AnyObject]
        //文章标题
        let atitle = articles["title"]
        //发布时间
        let r = NSRange(location: 0,length: 11)
        let postDate = articles["date"]!
        var postTime: NSString = postDate as! NSString
        postTime = postTime.substringWithRange(r)
        //文章正文
        let articleContent = articles["content"]
        //作者
        let author = articles["author"]
        //是否收藏
        let isUserCollect = articles["isUserCollect"]?.boolValue
        //显示文章
        let topHtml = "<html lang='zh-CN'><head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'><title>\(atitle!)</title><meta name='apple-itunes-app' content='app-id=639087967, app-argument=zhihudaily://story/4074215'><meta name='viewport' content='user-scalable=no, width=device-width'><link rel='stylesheet' href='http://203.195.152.45:8080/itjh/resource/zhihu.css'><script src='http://203.195.152.45:8080/itjh/resource/jquery.1.9.1.js'></script><base target='_blank'></head><body> <div class='main-wrap content-wrap'> <div class='content-inner'> <div class='question'> <h2 class='question-title' >\(atitle!)</h2> <div class='answer'> <div class='meta' style='padding-bottom:10px;border-bottom:1px solid #e7e7eb '> <span class='bio'>\(postTime)</span> &nbsp; <span class='bio'>\(author!)</span> </div> <div class='content'>"
        let footHtml = " </div> </div> </div>           </boby></script> </body> <script>$('img').attr('style', '');$('img').attr('width', '');$('img').attr('height', '');$('img').attr('class', '');$('img').attr('title', '');$('p').attr('style', '');</script></html>"
        
        success("\(topHtml)\(articleContent!)\(footHtml)", isUserCollect!)
      } else {
        fail(result.debugDescription)
      }
    }
    
    return request
  }
  
  ///  Login api
  ///
  ///  - parameter param:   paramter to log in
  ///  - parameter success: success callback
  ///  - parameter fail:    fail callback
  ///
  ///  - returns: Request object
  static func login(param: [String: AnyObject], success: ([String: AnyObject] ->Void), fail: () ->Void) ->Request {
    let request = Manager.sharedInstance.request(.POST, HttpURL.loginUrl(), parameters: param, encoding: ParameterEncoding.JSON, headers: nil)
    
    request.responseJSON { (_, _, result) -> Void in
      if result.isSuccess {
        if let value = result.value as? NSDictionary, let r = value["result"] as? Int, let people = value["people"] as? [String: AnyObject] {
          if (r == 1) {
            success(people)
          } else {
            fail()
          }
        } else {
          fail()
        }
      } else {
        fail()
      }
    }
    
    return request
  }
  
  ///  Store article api
  ///
  ///  - parameter parameter: parameter
  ///  - parameter success:   success callback
  ///  - parameter fail:      fail callback
  ///
  ///  - returns: Request object
  static func store(parameter: [String: AnyObject], success: ([String: AnyObject] ->Void), fail: () ->Void) ->Request {
    let request = Manager.sharedInstance.request(.POST, HttpURL.storeArticleUrl(), parameters: parameter, encoding: ParameterEncoding.JSON, headers: nil)
    
    request.responseJSON { (_, _, result) -> Void in
      if result.isSuccess {
        if let value = result.value as? [String: AnyObject] {
          success(value)
        } else {
          fail()
        }
      } else {
        fail()
      }
    }
    
    return request
  }
}