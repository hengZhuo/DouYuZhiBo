//
//  CustomNavigationController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/23.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
         //1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else{ return }
        //2.获取手势添加到View中
       guard let gesView = systemGes.view else{return}
        //3.获取target/action
        //3.1利用运行时机制查看属性
       /* var count : uint = 0
       let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name  = ivar_getName(ivar)
            print(String(cString:name!))
            
        }*/
        let targets = systemGes.value(forKey: "_targets") as! [NSObject]
        let targetObjc = targets.first
        //取出target
        let target = targetObjc?.value(forKey: "target")
        //3.3取出action
        let action = Selector(("handleNavigationTransition:"))
        //4.创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target!, action: action)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }

}
