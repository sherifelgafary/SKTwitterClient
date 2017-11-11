//
//  UserDetailsViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/11/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import GSKStretchyHeaderView

class UserDetailsViewController: BaseViewController {
    
    @IBOutlet weak var userDataTableView: UITableView!
    var userObject:UserModel?
    var stretchyHeaderView:UserProfileDataHeaderView?
    
    override class func instance()->UserDetailsViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpUserDataTableView()
        self.getLatestTweets()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpUserDataTableView() {
        self.userDataTableView.rowHeight = UITableViewAutomaticDimension
        self.userDataTableView.estimatedRowHeight = 50
        
        let nibViews = Bundle.main.loadNibNamed("UserProfileDataHeaderView", owner: self, options: nil)
        self.stretchyHeaderView = nibViews?.first as? UserProfileDataHeaderView
        
        self.userDataTableView.showsVerticalScrollIndicator = false
        self.userDataTableView.showsHorizontalScrollIndicator = false
        
        
        self.stretchyHeaderView?.bindHeaderWithUserObject(user: self.userObject!, parentVcObject: self)
        self.userDataTableView.addSubview(self.stretchyHeaderView!)
    }
    
    @IBAction func backTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getLatestTweets()  {
        showLoader(view: self.view)
        self.userObject?.getMyLatestTweetsList(pageSize: "10", completion: { (success, message) in
            dissmissLoader()
            if success == false{
                alertWithTitleInViewController(self, title: "Alert", message: message)
            }
            self.userDataTableView.reloadData()
        })
    }
}

extension UserDetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  (self.userObject?.tweets.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTweetTableViewCell", for: indexPath) as? UserTweetTableViewCell
        cell?.backgroundColor = .clear
        cell?.bindCellWith(userObject: self.userObject!, tweetIndex: indexPath.row)
        return cell!
    }
}
