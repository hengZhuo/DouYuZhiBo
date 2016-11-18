//
//  CycleModel.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/17.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    //标题
    var title = ""
    //图片
    var pic_url = ""
    //主播信息对应的字典
    var room : [String:NSObject]?{
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
     }
    }
    //主播对应的模型对象
    var anchor : AnchorModel?
    
    //自定义构造函数
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
    
    
}
