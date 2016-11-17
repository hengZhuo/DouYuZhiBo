//
//  AnchorModel.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/16.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    //房间号
    var room_id : Int = 0
    //房间图片
    var vertical_src = ""
    //判断是手机还是电脑直播 0：手机 1：电脑
    var isVertical : Int = 0
    //房间名字
    var room_name = ""
    //主播昵称
    var nickname = ""
    //观看人数
    var online : Int = 0
    //所在城市
    var anchor_city = ""
    
    init(dict:[String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
    
}
