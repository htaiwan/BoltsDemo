//
//  NSoperationDemo2ViewController.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

class NSoperationDemo2ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!

    let operationQueue = NSOperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func download(sender: UIButton) {
        
        let url = NSURL(string: "http://imgsrc.hubblesite.org/hu/db/images/hs-2006-10-a-hires_jpg.jpg")!
        
        let docsDir = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first!
        let docsUrl = NSURL(fileURLWithPath: docsDir)
        let targetUrl = docsUrl.URLByAppendingPathComponent("hubble.jpg")
        let targetPath = "\(targetUrl)"
        
        let downloadOperation = DownloadImageOperation(imageURL: url, targetPath: targetPath)
        
        downloadOperation.progressBlock = {self.progressView.progress = $0}
        
        downloadOperation.completionBlock = {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.imageView.image = downloadOperation.image
            })
        }
        
        operationQueue.addOperation(downloadOperation)
    }
    
}
