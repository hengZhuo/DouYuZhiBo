//
//  GameModel.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/18.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    var tag_name = ""
    var icon_url = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    
}
