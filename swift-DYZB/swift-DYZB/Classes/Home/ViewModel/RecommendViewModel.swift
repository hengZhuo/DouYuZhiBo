//
//  RecommendViewModel.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/16.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class RecommendViewModel {

    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    
}

// MARK:- 发送网络请求
extension RecommendViewModel{
    func requestData() {
        
        
        
        //1.请求推荐数据
         NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameters: ["limit": "4","offset":"0","time":NSDate.getCurrentTime()], finishedCallback:{ (result) in
            guard let resultDict = result as? [String:NSObject] else{return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{return}
            
            //3.1创建组
            let group = AnchorGroup()
            //3.2设置组的属性
            group.tag_name = "热门"
            group.icon_name = "home_header_hot"
            //3.3获取直播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }

         })
        //2.请求第二部份的颜值数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters: ["limit": "4","offset":"0","time":NSDate.getCurrentTime()], finishedCallback:{ (result) in
            
            guard let resultDict = result as? [String:NSObject] else{return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{return}
            
            //3.1创建组
            let group = AnchorGroup()
            //3.2设置组的属性
            group.tag_name = "颜值"
            group.icon_name = "home_header_phone"
            //3.3获取直播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                group.anchors.append(anchor)
            }
            
        })
        //3.请求后面部分的游戏数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit": "4","offset":"0","time":NSDate.getCurrentTime()],finishedCallback:{ (result) in
         //1、将result转成字典类型
            guard let resultDict = result as? [String:NSObject] else{return}
            
            //2.根据data的key,获取数组
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else{return}
            //3.便利数组获取字典，并将字典转成模型对象
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
        })
    }
}

