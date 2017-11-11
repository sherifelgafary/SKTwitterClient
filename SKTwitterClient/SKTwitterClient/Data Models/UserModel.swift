//
//  UserModel.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter
import KeychainAccess

class UserModel: BaseDataModel, NSCoding {
    
    var userOATHToken = ""
    var userOATHTokenSecret = ""
    var userID = ""
    var userName = ""
    var userScreenName = ""
    var userHandle = ""
    var userBio = ""
    var userProfileCoverImageUrl = ""
    var userProfileImageUrl = ""
    var tweets = [TweetsModel]()
    
    override class func getModelObjectFromAPIDictionary(dataDictionary:[String:AnyObject]) -> UserModel{
        let user = UserModel()
        user.userID = dataDictionary["id"] as? String ?? ""
        user.userName = dataDictionary["name"] as? String ?? ""
        user.userScreenName = dataDictionary["screen_name"] as? String ?? ""
        user.userBio = dataDictionary["description"] as? String ?? ""
        user.userProfileCoverImageUrl = dataDictionary["profile_banner_url"] as? String ?? ""
        user.userProfileImageUrl = dataDictionary["profile_image_url_https"] as? String ?? ""
        return user
    }
    
    override init() {
    }
    
    required init(coder decoder: NSCoder) {
        self.userOATHToken = decoder.decodeObject(forKey: "userOATHToken") as? String ?? ""
        self.userOATHTokenSecret = decoder.decodeObject(forKey: "userOATHTokenSecret") as? String ?? ""
        self.userID = decoder.decodeObject(forKey: "userID") as? String ?? ""
        self.userName = decoder.decodeObject(forKey: "userName") as? String ?? ""
        self.userScreenName = decoder.decodeObject(forKey: "userScreenName") as? String ?? ""
        self.userHandle = decoder.decodeObject(forKey: "userHandle") as? String ?? ""
        self.userBio = decoder.decodeObject(forKey: "userBio") as? String ?? ""
        self.userProfileCoverImageUrl = decoder.decodeObject(forKey: "userProfileCoverImageUrl") as? String ?? ""
        self.userProfileImageUrl = decoder.decodeObject(forKey: "userProfileImageUrl") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userOATHToken, forKey: "userOATHToken")
        coder.encode(userOATHTokenSecret, forKey: "userOATHTokenSecret")
        coder.encode(userID, forKey: "userID")
        coder.encode(userName, forKey: "userName")
        coder.encode(userScreenName, forKey: "userScreenName")
        coder.encode(userHandle, forKey: "userHandle")
        coder.encode(userBio, forKey: "userBio")
        coder.encode(userProfileCoverImageUrl, forKey: "userProfileCoverImageUrl")
        coder.encode(userProfileImageUrl, forKey: "userProfileImageUrl")
    }
    
    func saveUserAUTHData() {
        let keychain = Keychain(service: "SherifKhaled.SKTwitterClient")
        keychain["userOATHToken"] = self.userOATHToken
        keychain["userOATHTokenSecret"] = self.userOATHTokenSecret
    }
    
    func getUserAUTHData() {
        let keychain = Keychain(service: "SherifKhaled.SKTwitterClient")
        self.userOATHToken = keychain["userOATHToken"] ?? ""
        self.userOATHTokenSecret = keychain["userOATHTokenSecret"] ?? ""
    }
    
    func removeUserAUTHData() {
        let keychain = Keychain(service: "SherifKhaled.SKTwitterClient")
        keychain["userOATHToken"] = nil
        keychain["userOATHTokenSecret"] = nil
    }
    
    
    
    class func getFollowersList(currentPage:String ,pageSize:String ,completion:@escaping (_ followers:[UserModel],_ message:String,_ nextPage:String)-> Void) {
        if isConnectedToNetwork() {
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
        }else{
            var followers = [UserModel]()
            if let data = UserDefaults.standard.data(forKey: "followers"){
                if let chachedFollowers = NSKeyedUnarchiver.unarchiveObject(with: data) as? [UserModel]{
                    followers  = chachedFollowers
                }
            }
            completion(followers, "", currentPage)
        }
    }
    
    func getMyLatestTweetsList(pageSize:String ,completion:@escaping (_ success:Bool,_ message:String)-> Void) {
        TweetsModel.getTweetsListForUserScreenName(userScreenName: self.userScreenName, "10") { (tweetsArray, message) in
            var success = false
            if message == ""{
                success = true
            }
            self.tweets = tweetsArray
            completion(success,message)
        }
    }
    
}
