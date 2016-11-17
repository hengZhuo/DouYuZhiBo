//
//  NSDate-Extension.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/16.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime()->String {
        let nowDate = NSDate()
        let interval = nowDate.timeIntervalSince1970
        return "\(interval)"
    }
}


