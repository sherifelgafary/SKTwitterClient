//
//  UserTweetTableViewCell.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/11/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

class UserTweetTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func bindCellWith(userObject:UserModel,tweetIndex:Int)  {
        self.userNameLabel.text = userObject.userName
        self.userHandleLabel.text = "@" + userObject.userScreenName
        self.tweetTextLabel.text = userObject.tweets[tweetIndex].tweetText
        self.tweetTimeLabel.text = userObject.tweets[tweetIndex].tweetTiming
    }
    
    
}
