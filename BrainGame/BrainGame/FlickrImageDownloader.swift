//
//  FlickrImageDownloader.swift
//  BrainGame
//
//  Created by ranjeetkumar on 18/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import Foundation
import UIKit

class FlickrImageDownloader {
    private init() {
    }
    static let sharedInstance = FlickrImageDownloader();
    static let placeholderImage = UIImage(named: "placeholderImage");
    
    let queue = DispatchQueue(label: "com.brainGame.imageQueue")
    let group = DispatchGroup()
    var notify:(()->())? = nil
    private var count = 1
    func updateView(imageView:UIImageView, flickr: FlickrCardType) -> Void {
        
        guard let url =  flickr.imageUrl else {
            return
        }
        
        group.enter()
        imageView.af_setImage(withURL: url, placeholderImage: FlickrImageDownloader.placeholderImage, filter: nil, progress: nil, progressQueue: queue, imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false) {(image) in
            imageView.image = image.result.value
            self.group.leave()
        }
        group.notify(queue: DispatchQueue.main, execute: receivedAllImages)
    }
    
    func receivedAllImages() -> Void {
        if count == maxCardCount, let callBack = notify
        {
            callBack();
            count = 1
        }
        count += 1
    }

}
