//
//  ViewController.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/3/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit
import Bolts


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        let manager = GoogleManager()
//        
//        manager.getAddress1(adderss: "台北市內湖區民權東路6段280巷155弄213號6樓之21") { (error, result) -> () in
//            if error == nil {
//                print("成功1") // 第一層地獄
//                manager.getAddress1(adderss: "台北市內湖區民權東路6段280巷155弄213號6樓之21", completionHandler: { (error, result) -> () in
//                    if error == nil {
//                        print("成功2") // 第二層地獄
//                        manager.getAddress1(adderss: "台北市內湖區民權東路6段280巷155弄213號6樓之21", completionHandler: { (error, result) -> () in
//                            if error == nil {
//                                print("成功3") // 第三層地獄
//                                manager.getAddress1(adderss: "台北市內湖區民權東路6段280巷155弄213號6樓之21", completionHandler: { (error, result) -> () in
//                                    if error == nil {
//                                        print("成功4") // // 第四層地獄
//                                    } else {
//                                        print("失敗")
//                                    }
//                                })
//                            } else {
//                                print("失敗")
//                            }
//                        })
//                        
//                    } else {
//                        print("失敗")
//                    }
//                })
//            } else {
//                print("失敗")
//            }
//        }
//
//        
//        manager.getAddress2(adderss: "台北市內湖區民權東路5段140巷155弄213號20樓")
//        .continueWithSuccessBlock { (task) -> AnyObject! in
//            print("成功1") // 1. 當成功時，繼續執行下個API呼叫
//            
//            return manager.getAddress2(adderss: "台北市內湖區民權東路5段140巷155弄213號20樓")
//        }.continueWithSuccessBlock { (task) -> AnyObject! in
//            print("成功2") // 2. 當成功時，繼續執行下個API呼叫
//            
//            return manager.getAddress2(adderss: "") // 3. 此時這隻API，我故意不傳任何參數導致fail
//        }.continueWithSuccessBlock { (task) -> AnyObject! in
//            print("成功3") // 5. 這個將不會執行
//            
//            return manager.getAddress2(adderss: "台北市內湖區民權東路5段140巷155弄213號20樓")
//        }.continueWithSuccessBlock { (task) -> AnyObject! in
//            print("成功4") // 6. 這個也不會執行
//            
//            return nil
//        }.continueWithBlock { (task) -> AnyObject! in
//            if task.error != nil {
//                print("失敗") // 4. 由於3執行失敗，直接會跳到這個block
//                print("\(task.error)")
//            }
//            return nil
//        }
//        
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let manager = ApiManager()
        
        
        manager.fetchGetResponse()
        .continueWithSuccessBlock { (task) -> AnyObject! in
                print("fetchGetResponse 成功了")
                print("\(task.result)")
                
                return manager.postCustomerName("Alex")
        }.continueWithSuccessBlock { (task) -> AnyObject! in
            print("postCustomerName 成功了")
            print("\(task.result)")
            
            return manager.fetchImage()
        }.continueWithSuccessBlock { (task) -> AnyObject! in
            print("fetchImage 成功了")
            print("\(task.result)")
            
            self.imageView.image = task.result as? UIImage
            
            return nil
        }.continueWithBlock { (task) -> AnyObject! in
            if task.error != nil {
                print("失敗了")
                print("\(task.error)")
            }
            
            return nil
        }
        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

