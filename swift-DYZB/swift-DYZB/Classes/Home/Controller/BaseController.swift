//
//  BaseController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/22.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    var baseView : UIView?
    
    // MARK:- 懒加载
   fileprivate lazy var animImageView: UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
         imageView.center = self.view.center
         imageView.animationImages = [UIImage(named:"img_loading_1")!,UIImage(named:"img_loading_2")!]
          imageView.animationDuration = 0.5
           imageView.animationRepeatCount = LONG_MAX
    imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

// MARK:- 设置UI界面
extension BaseController{
   fileprivate func setUpUI() {
        view.backgroundColor = UIColor.white
        //执行动画
        view.addSubview(animImageView)
        animImageView.startAnimating()
    }
    func stopAnimImageView() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
    }
    
}


