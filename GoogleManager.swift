//
//  GoogleManager.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/3/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit
import AFNetworking
import Bolts

class GoogleManager: NSObject {
    
    var isLogin: Bool {
        return false // 測試mockup, 只要當正常登入帳號後，才可以使用API
    }
    let baseURL = "http://maps.googleapis.com/maps/api/geocode/json?"
    let manager = AFHTTPSessionManager()
    
 
    
    func getAddress1(adderss address: String,
        completionHandler:(error: NSError?, result: NSDictionary?)-> ()) {
            
            manager.requestSerializer.timeoutInterval = 2
            
            let parameters = NSMutableDictionary()
            parameters.setObject(address, forKey: "address")
            parameters.setObject(false, forKey: "sensor")
            
            manager.GET(baseURL, parameters: parameters, success: { (task, respondObject) -> Void in
                let dic = respondObject as! NSDictionary
                if let status = dic["status"] {
                    if status as! String == "OK" {
                        completionHandler(error: nil, result: dic)
                    } else {
                        let error = NSError(domain: "Error A", code: 100, userInfo: nil)
                        completionHandler(error: error, result: nil)
                    }
                }
            }) { (task, error) -> Void in
                let error = NSError(domain: "Error B", code: 101, userInfo: nil)
                completionHandler(error: error, result: nil)
                print("failure: \(error)")
            }
            
    }
    
    
    func getAddress2(adderss address: String) -> BFTask {
        
        let source = BFTaskCompletionSource() // 1.

        manager.requestSerializer.timeoutInterval = 2
        
        let parameters = NSMutableDictionary()
        parameters.setObject(address, forKey: "address")
        parameters.setObject(false, forKey: "sensor")
        
        manager.GET(baseURL, parameters: parameters, success: { (task, respondObject) -> Void in
            let dic = respondObject as! NSDictionary
            if let status = dic["status"] {
                if status as! String == "OK" {
                    source.setResult(dic) // 2. 將成功結果放到Result中
                } else {
                    let error = NSError(domain: "Error A", code: 100, userInfo: nil)
                    source.setError(error) // 3. 將錯誤訊息放到Error中
                }
            }
            }) { (task, error) -> Void in
                let error = NSError(domain: "Error B", code: 101, userInfo: nil)
                source.setError(error) // 4. 將錯誤訊息放到Error中
        }
        
        return source.task // 5. 回傳BFTask
    }
    
    
    // 練習Mockup的使用
    func getAddress3(adderss address: String,
        completionHandler:(error: NSError?, result: NSDictionary?)-> ()) {
            
            manager.requestSerializer.timeoutInterval = 2
            
            let parameters = NSMutableDictionary()
            parameters.setObject(address, forKey: "address")
            parameters.setObject(false, forKey: "sensor")
            
            manager.GET(baseURL, parameters: parameters, success: { (task, respondObject) -> Void in
                if self.isLogin == true {
                    let dic = respondObject as! NSDictionary
                    if let status = dic["status"] {
                        if status as! String == "OK" {
                            completionHandler(error: nil, result: dic)
                        } else {
                            let error = NSError(domain: "已登入，但參數不對", code: 100, userInfo: nil)
                            completionHandler(error: error, result: nil)
                        }
                    }
                } else {
                    // 未登入，不能使用API
                    let error = NSError(domain: "未登入", code: 100, userInfo: nil)
                    completionHandler(error: error, result: nil)
                }
                }) { (task, error) -> Void in
                    let error = NSError(domain: "網路有問題", code: 101, userInfo: nil)
                    completionHandler(error: error, result: nil)
                    print("failure: \(error)")
            }
            
    }


}
