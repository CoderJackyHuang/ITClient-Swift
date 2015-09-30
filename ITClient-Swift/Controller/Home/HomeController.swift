//
//  HomeController.swift
//  ITClient-Swift
//
//  Created by huangyibiao on 15/9/24.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

import Foundation
import UIKit

class HomeController: TechnologyController {
  override var category: Int {
    return 0
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hyb_navWithTitle("首页")
  }
}