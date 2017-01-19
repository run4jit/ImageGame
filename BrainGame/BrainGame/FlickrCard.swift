//
//  FlickrCard.swift
//  BrainGame
//
//  Created by ranjeetkumar on 18/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import Foundation

protocol FlickrCardType {
    var imageUrl: URL? {get}
    var cardNumber: String {get}
    func isCorrectCardNumber(number: UInt) -> Bool
}

class FlickrCard: FlickrCardType {
    var imageUrl: URL?
    var cardNumber: String
    
    private var imageStringUrl: String
    
    init(imgUrl: String, cardNumber: UInt) {
        self.imageStringUrl = imgUrl
        self.imageUrl = URL(string: imgUrl)
        self.cardNumber = "\(cardNumber)"
    }
    
    convenience init(json: [String: String], index: UInt) {
        let imageUrl = json["image_url"]  ?? "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"
        self.init(imgUrl: imageUrl, cardNumber: index + 1)
    }
    
    static func == (lhs: FlickrCardType, rhs: FlickrCard) -> Bool {
        return lhs.cardNumber == rhs.cardNumber
    }
    
    func isCorrectCardNumber(number: UInt) -> Bool
    {
        return number == UInt(cardNumber)
    }
    
    func getCardIndex() -> Int {
        guard let index = Int(self.cardNumber) else {
            return -1
        }
        
        return index - 1;
    }
}
