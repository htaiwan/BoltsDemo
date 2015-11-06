//
//  DownloadImageOperation.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/5/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

class DownloadImageOperation: AsynOperation, NSURLSessionDownloadDelegate {
    
    let imageURL: NSURL
    let targetPath: String
    var image: UIImage?
    
    var downloadTask: NSURLSessionDownloadTask?
    // 定義一個進度的block
    var progressBlock:(Float) -> () = { _ in }
    
    init(imageURL: NSURL, targetPath: String) {
        self.imageURL = imageURL
        self.targetPath = targetPath
    }
    
    lazy var session: NSURLSession = {
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        return NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    // 此呼叫會出現問題，此時main會直接執行，不會等到downloadTaskWithURL的callback回來
    // 所以我們要改用Asyn Nsoperation，來接這個callback
//    override func main() {
//        session.downloadTaskWithURL(imageURL) { (url, response, error) -> Void in
//            
//        }
//    }
    
    override func execute() {
        
        if NSFileManager.defaultManager().fileExistsAtPath(targetPath) {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(targetPath)
            } catch let error as NSError {
                print("Could not remove: \(error)")
            }
        }
        
        downloadTask = session.downloadTaskWithURL(imageURL)
        downloadTask?.resume()
    }
    
    
    // MARK: - NSURLSessionDownloadDelegate Method
    
    func URLSession(session: NSURLSession,
        downloadTask: NSURLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64) {
            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
            print("progress: \(progress)")
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                // block的實作
                self.progressBlock(progress)
            }
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        let fileHandle:NSFileHandle = NSFileHandle(forReadingAtPath: location.path!)!
        let data:NSData = fileHandle.readDataToEndOfFile()
        image = UIImage(data: data)!
        
        finish()
    }
    

}
