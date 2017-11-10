//
//  FollwerListStyleCollectionViewCell.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/10/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import AFNetworking

class FollwerListStyleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var cellWidthConstraint: NSLayoutConstraint!
    
    
    
    func bindWithFollowerObject(follower:UserModel)  {
        self.userHandleLabel.text = "@\(follower.userScreenName)"
        self.userBioLabel.text = follower.userBio
        self.userScreenNameLabel.text = follower.userName
        if let imageUrl = URL(string: follower.userProfileImageUrl) {
            self.userImageView.setImageWith( imageUrl, placeholderImage: UIImage(named:"Temp"))
        }else{
            self.userImageView.image = UIImage(named:"Temp")
        }
    }
}
