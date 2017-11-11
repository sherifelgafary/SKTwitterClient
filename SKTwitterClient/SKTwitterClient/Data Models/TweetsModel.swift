//
//  TweetsModel.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/11/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter

class TweetsModel: BaseDataModel {
    var tweetText = ""
    var tweetTiming = ""
    
    override class func getModelObjectFromAPIDictionary(dataDictionary:[String:AnyObject]) -> TweetsModel{
        let tweet = TweetsModel()
        tweet.tweetText = dataDictionary["text"] as? String ?? ""
        tweet.tweetTiming = dataDictionary["created_at"] as? String ?? ""
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        let oldDate = dateFormatter.date(from: tweet.tweetTiming)!
        
        dateFormatter.dateFormat = "E, dd/MMM/yyyy hh:mm a"
        tweet.tweetTiming = dateFormatter.string(from: oldDate)
        
        return tweet
    }
    
    
    class func getTweetsListForUserScreenName(userScreenName:String ,_ pageSize:String ,completion:@escaping (_ tweetsArray:[TweetsModel],_ message:String)-> Void) {
        twitterClient.getUserTimeline(withScreenName: userScreenName, count: 10, successBlock: { (dataArray) in
            if let tweets = dataArray as? [[String:AnyObject]]{
                var tweetsArray = [TweetsModel]()
                for item in tweets{
                    tweetsArray.append(TweetsModel.getModelObjectFromAPIDictionary(dataDictionary: item))
                }
                completion(tweetsArray,"")
            }else{
                completion([],"error happened please try again later")
            }
            
        }) { (error) in
            completion([],(error?.localizedDescription)!)
        }
    }
    
}
