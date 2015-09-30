//
//  HttpURL.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import UIKit

///  HTTP URL
///
/// Author: 黄仪标
/// Blog:   http://www.hybblog.com/
/// Github: http://github.com/CoderJackyHuang/
/// Email:  huangyibiao520@163.com
/// Weibo:  JackyHuang（标哥）
struct HttpURL {
  ///  Get log in url
  ///
  ///  - returns: The absolute url to log in
  static func loginUrl() ->String {
    return baseUrl + "PeopleServer/saveUser/"
  }
  
  ///  Get the url of category of technology
  ///
  ///  - parameter currentPage: Current page index
  ///  - parameter pageSize:    How many rows to load
  ///
  ///  - returns: The absolute url
  static func technologyUrl(currentPage: Int, pageSize: Int) ->String {
   let url = "ArticleServer/queryArticleListByCategory/2"
    
    return baseUrl + "\(url)/\(currentPage)/\(pageSize)"
  }
  
  ///  Get home url
  ///
  ///  - parameter currentPage: Current page index
  ///  - parameter pageSize:    How many rows to load
  ///
  ///  - returns: The absolute url
  static func homeUrl(currentPage: Int, pageSize: Int) ->String {
    let url = "ArticleServer/queryArticleListByNew/"
    
    return baseUrl + url + "\(currentPage)/\(pageSize)"
  }
  
  ///  Get interest url
  ///
  ///  - parameter currentPage: Current page index
  ///  - parameter pageSize:    How many rows to load
  ///
  ///  - returns: The absolute url
  static func interestUrl(currentPage: Int, pageSize: Int) ->String {
    let url = "ArticleServer/queryArticleListByCategory/4"
    
    return baseUrl + "\(url)/\(currentPage)/\(pageSize)"
  }
  
  ///  Get article detail url
  ///
  ///  - parameter articleId: The id of an article
  ///  - parameter userId:    user id, if user have logined.
  ///
  ///  - returns: The absolute url of article details
  static func articleUrl(articleId: String, userId: String = "") ->String {
    let url = "ArticleServer/queryArticleById/\(articleId)"
    if userId.isEmpty {
      return baseUrl + url
    }
    
    return baseUrl + url + "?userId=\(userId)"
  }
  
  ///  Get collect article url
  ///
  ///  - returns: The absolute url of collecting article
  static func storeArticleUrl() ->String {
    let url = "poas/userCollectionArticle"
    
    return baseUrl + url
  }

  private static var baseUrl = "http://api.itjh.net/v1/"
}