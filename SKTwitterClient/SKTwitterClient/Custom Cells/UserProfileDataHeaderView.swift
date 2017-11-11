//
//  UserProfileData.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/11/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView
import AFNetworking
import Agrume

class UserProfileDataHeaderView: GSKStretchyHeaderView {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    var parentVC:UIViewController?
    var userObject:UserModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = appBlueColor
        self.expansionMode = .topOnly
        self.minimumContentHeight = 64
        self.navigationTitleLabel.isHidden = true
    }
    
    override func didChangeStretchFactor(_ stretchFactor: CGFloat) {
        var alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1)
        alpha = max(0, min(1,alpha))
        self.userImage.alpha = alpha;
        self.userNameLabel.alpha = alpha;
        self.userHandleLabel.alpha = alpha;
        //        self.backgroundImageView.alpha = alpha;
        let navTitleFactor:CGFloat = 0.4;
        var navTitleAlpha:CGFloat = 0;
        if (stretchFactor < navTitleFactor) {
            navTitleAlpha = CGFloatTranslateRange(stretchFactor, 0, navTitleFactor, 1, 0)
            self.navigationTitleLabel.isHidden = false
        }else{
            self.navigationTitleLabel.isHidden = true
        }
        self.navigationTitleLabel.alpha = navTitleAlpha;
    }
    
    @IBAction func profileImageTapped(sender: UIButton) {
        self.openImageInOverLayView(imageUrl: (self.userObject?.userProfileImageUrl)!)
    }
    
    @IBAction func profileHeaderTapped(sender: UIButton) {
        self.openImageInOverLayView(imageUrl: (self.userObject?.userProfileCoverImageUrl)!)
    }
    
    func openImageInOverLayView(imageUrl:String)  {
        if let url = URL(string:imageUrl) {
            let agrume = Agrume(imageUrl: url, backgroundBlurStyle: UIBlurEffectStyle.light, backgroundColor: .clear)
            agrume.showFrom(self.parentVC!)
        }else{
            alertWithTitleInViewController(self.parentVC!, title: "Alert", message: "Image Url not avilable")
        }
    }
    
    func bindHeaderWithUserObject(user:UserModel,parentVcObject:UIViewController)  {
        self.userObject = user
        self.parentVC = parentVcObject
        
        self.userNameLabel.text = user.userName
        self.userHandleLabel.text = "@" + user.userScreenName
        self.navigationTitleLabel.text = "@" + user.userScreenName
        
        if let imageUrl = URL(string: user.userProfileImageUrl) {
            self.userImage.setImageWith( imageUrl, placeholderImage: UIImage(named:"Temp"))
        }else{
            self.userImage.image = UIImage(named:"Temp")
        }
        
        if let imageUrl = URL(string: user.userProfileCoverImageUrl) {
            self.backgroundImageView.setImageWith( imageUrl, placeholderImage: UIImage(named:"Temp"))
        }else{
            self.backgroundImageView.image = UIImage(named:"Temp")
        }
        
    }
    
}
