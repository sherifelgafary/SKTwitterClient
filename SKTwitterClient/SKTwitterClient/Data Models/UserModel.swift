//
//  UserModel.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter

class UserModel: BaseDataModel {
    
    var userOATHToken = ""
    var userOATHTokenSecret = ""
    var userID = ""
    var userName = ""
    var userScreenName = ""
    var userHandle = ""
    var userBio = ""
    var userProfileCoverImageUrl = ""
    var userProfileImageUrl = ""
    var userProfileImageObject = UIImage(named:"Temp")
    
    class func getModelObjectFromAPIDictionary(dataDictionary:[String:AnyObject]) -> UserModel{
        let user = UserModel()
        user.userID = dataDictionary["id"] as? String ?? ""
        user.userName = dataDictionary["name"] as? String ?? ""
        user.userScreenName = dataDictionary["screen_name"] as? String ?? ""
        user.userBio = dataDictionary["description"] as? String ?? ""
        user.userProfileCoverImageUrl = dataDictionary["profile_banner_url"] as? String ?? ""
        user.userProfileImageUrl = dataDictionary["profile_image_url_https"] as? String ?? ""
        return user
    }
    
    
    class func getFollowersList(currentPage:String ,pageSize:String ,completion:@escaping (_ followers:[UserModel],_ message:String,_ nextPage:String)-> Void) {
        twitterClient.getFollowersList(forUserID: appUser?.userID, orScreenName: appUser?.userScreenName, count: pageSize, cursor: currentPage, skipStatus: 1, includeUserEntities: 0, successBlock: { (response, previousCursor, nextCursor) in
            var followersArray = [UserModel]()
            
            if let dataArray = response as? [[String:AnyObject]]{
                for item in dataArray{
                    followersArray.append(UserModel.getModelObjectFromAPIDictionary(dataDictionary: item))
                }
            }
            completion(followersArray,"",nextCursor!)
        }) { (error) in
            completion([],(error?.localizedDescription)!,"-1")
        }
        

    }
    
}
