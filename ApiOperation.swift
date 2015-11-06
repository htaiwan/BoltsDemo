//
//  ApiOperation.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

class ApiOperation: NSOperation {
    
    var manager: ApiManager?
    
    init(manager: ApiManager) {
        self.manager = manager
    }
    
    override func main() {

//        // 檢查目前動作是否是在主執行緒上
//        assert(NSThread.isMainThread())

        for i in 1...5 {
            if cancelled {
                return
            }
            print("sleeping \(i)....")
            sleep(1)
        }
        
        if cancelled {
            return
        }
        
        callApi()
    }
    
    
    func callApi() {
        manager!.fetchGetResponse()
            .continueWithSuccessBlock { (task) -> AnyObject! in
                print("fetchGetResponse 成功了")
                print("\(task.result)")
                
                return self.manager!.postCustomerName("Alex")
            }.continueWithSuccessBlock { (task) -> AnyObject! in
                print("postCustomerName 成功了")
                print("\(task.result)")
                
                return self.manager!.fetchImage()
            }.continueWithSuccessBlock { (task) -> AnyObject! in
                print("fetchImage 成功了")
                print("\(task.result)")
                
                return nil
            }.continueWithBlock { (task) -> AnyObject! in
                if task.error != nil {
                    print("失敗了")
                    print("\(task.error)")
                }
                
                return nil
        }
    }
    
}
