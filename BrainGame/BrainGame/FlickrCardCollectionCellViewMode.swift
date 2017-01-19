//
//  FlickrCardCollectionCellViewMode.swift
//  BrainGame
//
//  Created by ranjeetkumar on 18/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import Foundation
import UIKit

protocol FlickrCardCollectionCellViewModeDelegate: class {
    func getCardCollectionCell() -> FlickrCardCollectionCell
}
class FlickrCardCollectionCellViewMode {

    var flickrCart: FlickrCardType
    var cellDelegate: FlickrCardCollectionCellViewModeDelegate?
    
    init(flickrCart:FlickrCardType) {
        self.flickrCart = flickrCart;
        self.cardViewUpdateOrReset(flickr: flickrCart)
    }
    func updateView(flickr: FlickrCardType) -> Void {
        
        guard let url =  flickr.imageUrl else {
            return
        }
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
