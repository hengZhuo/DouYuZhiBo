//
//  MainController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/14.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
       addChildVc(storyName: "Home")
       addChildVc(storyName: "Live")
       addChildVc(storyName: "Follow")
       addChildVc(storyName: "Profile")
    }
    
   private func addChildVc(storyName:String) {
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        
        //2.将childVC作为子控制器
        addChildViewController(childVc!)
    }


}
