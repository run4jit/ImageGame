//
//  FlickrCardCollectionCell.swift
//  BrainGame
//
//  Created by ranjeetkumar on 18/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class FlickrCardCollectionCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var flickrCardImageView: UIImageView!
    @IBOutlet weak var flickrCardNumber: UILabel!
     
    func updateView(flickr: FlickrCardType) -> Void {
        
        FlickrImageDownloader.sharedInstance.updateView(imageView: flickrCardImageView, flickr: flickr)
        flickrCardNumber.text = flickr.cardNumber
        numberLabel.text = flickr.cardNumber
    }
    
    func resetCardView() -> Void {
        flickrCardImageView.image = nil;
        flickrCardNumber.text = "";
    }
    
    func cardViewUpdateOrReset(flickr: FlickrCardType?) -> Void {
        if let card =  flickr
        {
            updateView(flickr: card)
        }
        else
        {
            resetCardView()
        }
    }
}
