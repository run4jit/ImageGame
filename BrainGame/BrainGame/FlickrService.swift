//
//  FlickrService.swift
//  BrainGame
//
//  Created by ranjeetkumar on 17/01/17.
//  Copyright © 2017 ranjeetkumar. All rights reserved.
//

import Foundation
import Alamofire

class FlickrService {
    /*
    class func imageListService() -> [FlickrCardType]
    {
        let items = [["image_url" : "http://www.trendingtop5.com/wp-content/uploads/2015/07/most-beautiful-Island-in-the-world-640x400.jpeg"],
                     ["image_url" : "https://ceasefiremagazine.co.uk/wp-content/uploads/Jeju-Island.jpg"],
                     ["image_url" : "http://guardianlv.com/wp-content/uploads/2013/07/tavarua-island-resort_0-650x333.jpg"],
                     ["image_url" : "http://cdn.goodshomedesign.com/wp-content/uploads/2012/08/Desroches-Island-11-e1343867222862.jpg"],
                     ["image_url" : "http://www.bd24live.com/bn/photo_gallery/2015/05/29/Galapagos-islands.jpg"],
                     ["image_url" : "http://2.bp.blogspot.com/-H26NEC5pSTE/UePCqsI3FcI/AAAAAAAABWc/ouMxQKVgIu8/s1600/Bora+bora21.jpeg"],
                     ["image_url" : "http://3.bp.blogspot.com/-bPKETZWCHog/TyBYt3kHpJI/AAAAAAAAAIU/3fs28dt_1g4/s1600/Bora+Bora.jpg"],
                     ["image_url" : "http://2.bp.blogspot.com/-t__crJmHSNw/UIAF_GP5U9I/AAAAAAAABbA/8ZU9FeQbDVE/s1600/Bora-Bora-Tahiti-Society-Islands.jpg"],
                     ["image_url" : "http://trendzbee.com/wp-content/uploads/2016/09/10-Most-Beautiful-Islands-In-The-World-4.Tahiti-French-Polynesia-2.jpg"],
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
    */
    class func processResponse(json:[String: AnyObject]) -> [FlickrCardType] {
        
        var index: UInt = 0;
        var cards = [FlickrCard]()
        if let items = json["images"] as? Array<[String: String]>
        {
            for item in items {
                let card = FlickrCard(json: item, index: index)
                cards.append(card);
                index += 1
            }
        }
        return cards
    }
    class func imageListService(callBack:@escaping ([FlickrCardType]) -> Void ) ->  Void{
        let api = "http://www.mocky.io/v2/587f82342700004e04f0dd13"
        do {
            let url = try api.asURL()
            Alamofire.request(url)
            .validate(statusCode: 200..<300)
            .validate()
            .responseJSON(completionHandler: { (response) in
                debugPrint(response)
                if let json = response.result.value as? [String: AnyObject]
                {
                    let list = FlickrService.processResponse(json: json);
                    callBack(list);
                }
            })

        } catch  {
            print("Invalid api");
        }
    }
    
}
