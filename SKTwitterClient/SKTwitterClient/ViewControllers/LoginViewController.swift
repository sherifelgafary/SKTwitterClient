//
//  LoginViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter
import Accounts

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
            dissmissLoader()
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
            
            appUser?.saveUserAUTHData()
            
            let accountStore = ACAccountStore()
            let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
            let deviceToSaveAccount = ACAccount(accountType: accountType)
            deviceToSaveAccount?.credential = ACAccountCredential(oAuthToken: oauthToken, tokenSecret: oauthTokenSecret)
            deviceToSaveAccount?.username = screenName
            accountStore.saveAccount(deviceToSaveAccount, withCompletionHandler: { (saved, error) in
                DispatchQueue.main.async {
                    dissmissLoader()
                    self.redirectUserToHomeScreen()
                }
            
            })
            
        }, errorBlock: { (error) in
            dissmissLoader()
            alertWithTitleInViewController(self, title: "Alert", message: (error?.localizedDescription)!)
        })
    }
    
    
    @IBAction func twitterLogin(_ sender: UIButton) {
        twitterClient = STTwitterAPI(oAuthConsumerKey: consumerKey, consumerSecret: consumerSecret)
        twitterClient?.postTokenRequest({ (url, oauthToken) in
            showLoader(view: self.view)
            let authonticationWebView = AuthenticationWebViewViewController.instance()
            self.present(authonticationWebView , animated: true, completion: {
                let authenticationRequest = URLRequest(url: url!)
                authonticationWebView.webView.loadRequest(authenticationRequest)
            })
        }, oauthCallback: "SKTwitterClient://twitter_access_tokens/", errorBlock: { (error) in
            dissmissLoader()
            alertWithTitleInViewController(self, title: "Alert", message: (error?.localizedDescription)!)
        })
    }
    
    
    func redirectUserToHomeScreen()  {
        NotificationCenter.default.removeObserver(self)
        let homeVC = HomeViewController.instance()
        
        let nav = UINavigationController(rootViewController: homeVC)
        replaceCurrentVisableViewControllerWithViewController(viewController: nav)
    }
    
}
