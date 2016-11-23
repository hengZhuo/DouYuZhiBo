//
//  AmuseViewModel.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/22.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}


extension AmuseViewModel{
    func loadAmuseData(finishedCallback:@escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback:{(result) in
            
            guard let resultDic = result as? [String:Any]else{return}
            guard let resultArray = resultDic["data"] as? [[String:Any]]else{return}
            for dict in resultArray{
                self.anchorGroups.append(AnchorGroup(dict: dict as! [String : NSObject]))
            }
            finishedCallback()
        })
    }
}

