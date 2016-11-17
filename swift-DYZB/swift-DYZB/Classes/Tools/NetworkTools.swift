//
//  NetworkTools.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/16.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {

    class func requestData(type: MethodType, URLString: String, parameters:[String : String]? = nil, finishedCallback: @escaping(_ result : AnyObject) -> ()) {
        //1.获取类型
        let methods = type == .GET ? HTTPMethod.get : HTTPMethod.post
       Alamofire.request(URLString, method: methods, parameters: parameters).responseJSON { (response) in
        //1.校验是否有结果
        guard let result = response.result.value else {
            print(response.result.error!)
            return
        }
        //2.将结果回调出去
        finishedCallback(result as AnyObject)
        
        }
        
        
    }
    
}
