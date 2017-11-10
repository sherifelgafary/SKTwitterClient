//
//  SplashScreenViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter

class SplashScreenViewController: BaseViewController {
    
    @IBOutlet weak var twitterIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func openHomeScreen() {
        let homeVC = HomeViewController.instance()
        homeVC.showSplashAnimation = true
        homeVC.splashIconSize = self.twitterIconImageView.frame.size
        
        let nav = UINavigationController(rootViewController: homeVC)
        replaceCurrentVisableViewControllerWithViewController(viewController: nav)
    }
    
    func openLoginScreen() {
        let loginVC = LoginViewController.instance()
        loginVC.showSplashAnimation = true
        loginVC.splashIconSize = twitterIconImageView.frame.size
        replaceCurrentVisableViewControllerWithViewController(viewController: loginVC)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appUser = UserModel()
        appUser?.getUserAUTHData()
        if appUser?.userOATHTokenSecret != ""{
                twitterClient = STTwitterAPI(oAuthConsumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: appUser?.userOATHToken, oauthTokenSecret: appUser?.userOATHTokenSecret)
                
                twitterClient.verifyCredentials(userSuccessBlock: { (screenName, userID) in
                    appUser?.userID = userID!
                    appUser?.userScreenName = screenName!
                    self.openHomeScreen()
                }, errorBlock: { (error) in
                    self.openLoginScreen()
                })
            
        }else{
            self.openLoginScreen()
        }
    }
    
}
