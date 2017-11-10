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
    
    override func viewDidAppear(_ animated: Bool) {
        if let data = UserDefaults.standard.data(forKey: "appUser"){
            if let user = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserModel{
                appUser  = user
                twitterClient = STTwitterAPI(oAuthConsumerKey: consumerKey, consumerSecret: consumerSecret, oauthToken: appUser?.userOATHToken, oauthTokenSecret: appUser?.userOATHTokenSecret)
                
                let homeVC = HomeViewController.instance()
                homeVC.showSplashAnimation = true
                homeVC.splashIconSize = twitterIconImageView.frame.size
                
                let nav = UINavigationController(rootViewController: homeVC)
                nav.navigationBar.isTranslucent = false
                nav.navigationBar.barTintColor = appBlueColor
                replaceCurrentVisableViewControllerWithViewController(viewController: nav)
            }
        }else{
            let loginVC = LoginViewController.instance()
            loginVC.showSplashAnimation = true
            loginVC.splashIconSize = twitterIconImageView.frame.size
            replaceCurrentVisableViewControllerWithViewController(viewController: loginVC)
        }
    }
    
}
