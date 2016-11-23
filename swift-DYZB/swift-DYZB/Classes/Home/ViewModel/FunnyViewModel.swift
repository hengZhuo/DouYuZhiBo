//
//  FunnyViewModel.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/22.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class FunnyViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}

extension FunnyViewModel{
    func loadFunnyData(finishedCallBack:@escaping ()->()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit":"30","offset":"0"], finishedCallback: { (result) in
            guard let resultDic = result as? [String:Any]else{return}
            guard let resultArray = resultDic["data"] as? [[String:Any]]else{return}
            let group = AnchorGroup()
            for dict in resultArray{
              group.anchors.append(AnchorModel(dict: dict as! [String : NSObject]))
            }
            self.anchorGroups.append(group)
            
            finishedCallBack()
        })
    }
}

