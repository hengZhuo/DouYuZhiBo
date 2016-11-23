//
//  RoomNormalController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/23.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class RoomNormalController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //保持手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

extension RoomNormalController{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.orange
            }
}

