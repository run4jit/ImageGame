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
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var flickrCardImageView: UIImageView!
    @IBOutlet weak var flickrCardNumber: UILabel!
 
    static let placeholderImage = UIImage(named: "");
    
    func updateView(flickr: FlickrCardType) -> Void {

        guard let url =  flickr.imageUrl else {
            return
        }
        
        flickrCardImageView.af_setImage(withURL: url, placeholderImage: FlickrCardCollectionCell.placeholderImage, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: UIImageView.ImageTransition.noTransition, runImageTransitionIfCached: false) { (image) in
            self.flickrCardImageView.image = image.result.value
        }
        
        flickrCardNumber.text = flickr.cardNumber
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
