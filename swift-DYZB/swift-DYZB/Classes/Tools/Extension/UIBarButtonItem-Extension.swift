//
//  UIBarButtonItem-Extension.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/14.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func createItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    //便利构造函数 1.convenience开头 2.必须调用一个设计构造函数（self）
    convenience init(imageName:String,highImageName:String,size:CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        //设计函数
        self.init(customView:btn)
    }
}



