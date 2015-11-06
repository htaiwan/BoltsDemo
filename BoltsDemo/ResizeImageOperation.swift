//
//  ResizeImageOperation.swift
//  BoltsDemo
//
//  Created by CHENG-TAI CHENG on 11/6/15.
//  Copyright © 2015 CHENG-TAI CHENG. All rights reserved.
//

import UIKit

class ResizeImageOperation: AsynOperation {
    
    let sourceImage: UIImage
    let containingSize: CGSize
    
    init(image: UIImage,containingSize: CGSize) {
        self.sourceImage = image
        self.containingSize = containingSize
    }
    
    override func execute() {
        print("Source image size: \(sourceImage.size)")
        printSizeOnDisk(UIImageJPEGRepresentation(sourceImage, 1.0)!)
        
        let width: CGFloat
        let height: CGFloat
        let ratio = sourceImage.size.width / sourceImage.size.height
        if sourceImage.size.width >= sourceImage.size.height {
            width = containingSize.width
            height = width / ratio
        } else {
            height = containingSize.height
            width = height * ratio
        }
        
        let imageSize = CGSize(width: width, height: height)
        print("Resized image: \(imageSize)")
        
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 0.0)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
        sourceImage.drawInRect(rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imageData = UIImageJPEGRepresentation(resizedImage, 0.8)
        printSizeOnDisk(imageData!)
        
        finish()
    }
    
    
    func printSizeOnDisk(data: NSData) {
        let bytes = Int64(data.length)
        let size = NSByteCountFormatter.stringFromByteCount(bytes, countStyle: NSByteCountFormatterCountStyle.File)
        print("Size on disk: \(size)")
    }

}
