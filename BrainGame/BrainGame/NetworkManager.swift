//
//  NetworkManager.swift
//  BrainGame
//
//  Created by ranjeetkumar on 17/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import Foundation
import Alamofire

class FlickrService {
    class func imageListService() -> [FlickrCardType]
    {
        let items = [["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ["image_url" : "https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg"],
                     ]
        
        var index: UInt = 0;
        var cards = [FlickrCard]()
        for item in items {
            let card = FlickrCard(json: item, index: index)
            cards.append(card);
            index += 1
        }
        return cards
    }
}
/*
class NetworkService {
 
    
    
    class func request(url:NSURL, parameters:[String:String]?, header:[String:String]?, boady:[String:String]?, method:HTTPMethod) throws -> NSURLRequest
    {
        request(url, method: method, parameters: parameters, encoding: ParameterEncoding, headers: header)
    }
    
    func test(a: NSURLRequest, parameters:[String:String]?, headers:[String:String]?)
    {
        Alamofire.request(NSURL(string: "")! as NSURL , method: .get, parameters: parameters, encoding: URLEncoding., headers: headers)
        
    }
}
*/
