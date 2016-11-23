//
//  GameViewModel.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/18.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var gameModels : [GameModel] = [GameModel]()
}

extension GameViewModel{
    func loadAllGameData(finishedCallback:@escaping()->()) {
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"], finishedCallback: { (result) in
        
            //1.获取数据
            guard let resultData = result as? [String:Any] else{return}
            guard let resultArray = resultData["data"] as? [[String:Any]] else{return}
            //2.字典转模型
            for dict in resultArray{
               let gameModel = GameModel(dict: dict)
                self.gameModels.append(gameModel)
            }
           finishedCallback()
            
        })
    }
}


