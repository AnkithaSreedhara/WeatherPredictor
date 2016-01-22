//
//  ImageUtil.swift
//  Weather Predictor
//
//  Created by Anki on 15/01/16.
//  Copyright © 2016 Anki. All rights reserved.
//

import Foundation
import UIKit
class ImageUtil : NSObject{
    class func getImageFromUrl(urlString : String) -> UIImage {
        let url = NSURL(string: urlString)
        var imageUrl : UIImage = UIImage()
        if let data = NSData(contentsOfURL: url!){
            imageUrl = UIImage(data : data)!
        }
        return imageUrl
    }
}