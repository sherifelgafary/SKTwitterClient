//
//  FollwerGridStyleCollectionViewCell.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/10/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

class FollwerGridStyleCollectionViewCell: FollwerListStyleCollectionViewCell {
    @IBOutlet weak var userCoverImageView: UIImageView!

    
    override func bindWithFollowerObject(follower:UserModel)  {
        super.bindWithFollowerObject(follower: follower)
        if let imageUrl = URL(string: follower.userProfileCoverImageUrl) {
            self.userCoverImageView.setImageWith( imageUrl, placeholderImage: UIImage(named:"Temp"))
        }else{
            self.userCoverImageView.image = UIImage(named:"Temp")
        }
    }

}
