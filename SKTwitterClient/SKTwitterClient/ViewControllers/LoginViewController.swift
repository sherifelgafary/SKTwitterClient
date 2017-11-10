//
//  LoginViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter

class LoginViewController: BaseViewController {
    override class func instance()->LoginViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.handleAuthonticationSuccess(_:)), name: .TwitterAuthonticationSuccessNotification , object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.handleAuthonticationFailure(_:)), name: .TwitterAuthonticationFauilureNotification , object: nil)
    }
    
    
    @objc func handleAuthonticationFailure(_ notification: NSNotification) {
        self.dismiss(animated: true) {
            alertWithTitleInViewController(self, title: "Alert", message: "Please authorize app for your twitter account to login")
        }
    }
    
    @objc func handleAuthonticationSuccess(_ notification: NSNotification) {
        self.dismiss(animated: true) {}
        
        let verifier = notification.userInfo!["oauth_verifier"] as? String ?? ""
        
        twitterClient?.postAccessTokenRequest(withPIN: verifier, successBlock: { (oauthToken, oauthTokenSecret, userID, screenName) in
            appUser = UserModel()
            appUser?.userOATHToken = oauthToken!
            appUser?.userOATHTokenSecret = oauthTokenSecret!
            appUser?.userScreenName = screenName!
            appUser?.userID = userID!
            
            self.redirectUserToHomeScreen()
        }, errorBlock: { (error) in
            alertWithTitleInViewController(self, title: "Alert", message: (error?.localizedDescription)!)
        })
    }
    
//    func getUserBannarImage()  {
//        twitterClient.getUsersProfileBanner(forUserID: appUser?.userID, orScreenName: appUser?.userScreenName, successBlock: { (response) in
//
//            appUser?.userProfileCoverImageUrl = ""
//            if let result = response as? [String:AnyObject]{
//                if let sizes = result["sizes"] as? [String:AnyObject]{
//                    if let mobileRetina = sizes["mobile_retina"] as? [String:AnyObject] {
//                        appUser?.userProfileCoverImageUrl = mobileRetina["url"] as? String ?? ""
//                    }
//                }
//            }
//
//            self.getUserProfileImage()
//        }, errorBlock: { (error) in
//            appUser?.userProfileCoverImageUrl = ""
//            self.getUserProfileImage()
//        })
//
//    }
//
//    func getUserProfileImage()  {
//        twitterClient.profileImage(for: appUser?.userScreenName, successBlock: { (result) in
//            appUser?.userProfileImageObject = result as? UIImage ?? UIImage(named:"Temp")
//            self.redirectUserToHomeScreen()
//        }, errorBlock: { (error) in
//            appUser?.userProfileImageObject = UIImage(named:"Temp")
//            self.redirectUserToHomeScreen()
//        })
//    }
    
    @IBAction func twitterLogin(_ sender: UIButton) {
        twitterClient = STTwitterAPI(oAuthConsumerKey: consumerKey, consumerSecret: consumerSecret)
        twitterClient?.postTokenRequest({ (url, oauthToken) in
            let authonticationWebView = AuthenticationWebViewViewController.instance()
            self.present(authonticationWebView , animated: true, completion: {
                let authenticationRequest = URLRequest(url: url!)
                authonticationWebView.webView.loadRequest(authenticationRequest)
            })
        }, oauthCallback: "SKTwitterClient://twitter_access_tokens/", errorBlock: { (error) in
            alertWithTitleInViewController(self, title: "Alert", message: (error?.localizedDescription)!)
        })
    }
    
    
    func redirectUserToHomeScreen()  {
        NotificationCenter.default.removeObserver(self)
        let homeVC = HomeViewController.instance()
        
        let nav = UINavigationController(rootViewController: homeVC)
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barTintColor = appBlueColor
        replaceCurrentVisableViewControllerWithViewController(viewController: nav)
    }
    
}
