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
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barTintColor = appBlueColor
        replaceCurrentVisableViewControllerWithViewController(viewController: nav)
    }
    
    func openLoginScreen() {
        let loginVC = LoginViewController.instance()
        loginVC.showSplashAnimation = true
        loginVC.splashIconSize = twitterIconImageView.frame.size
        replaceCurrentVisableViewControllerWithViewController(viewController: loginVC)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.data(forKey: "appUser"){
            if let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserModel{
                appUser  = user
                twitterClient = STTwitterAPI(oAuthConsumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: appUser?.userOATHToken, oauthTokenSecret: appUser?.userOATHTokenSecret)
                
                twitterClient.verifyCredentials(userSuccessBlock: { (username, userID) in
                    self.openHomeScreen()
                }, errorBlock: { (error) in
                    self.openLoginScreen()
                })
                
            }
        }else{
            self.openLoginScreen()
        }
    }
    
}
