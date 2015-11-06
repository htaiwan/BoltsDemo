//
//  NSOperationDemoViewController.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit


class NSOperationDemoViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    let operationQueue = NSOperationQueue()
    let operation = ApiOperation(manager: ApiManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goButton.enabled = true
        cancelButton.enabled = false
        
//        operationQueue.maxConcurrentOperationCount = 1  // makes this a serial queue
//        operationQueue.suspended = true // use this if you don't want to automatically execute operations as they are added.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func go(sender: UIButton) {
        goButton.enabled = false
        cancelButton.enabled = true
        
        operationQueue.addOperation(operation)
        
        operation.completionBlock = { [weak self] in            
            // 丟回到主執行緒
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if self!.operation.cancelled {
                    print("cancel")
                } else {
                    self?.goButton.enabled = true
                    self?.cancelButton.enabled = false
                }
            })
        }
        
    }
    
    @IBAction func cancel(sender: UIButton) {
        // 取消某個特定的operation
        operation.cancel()
    }
    

}
