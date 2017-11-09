//
//  LoginViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: BaseViewController {

    override class func instance()->UIViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func twitterLogin(_ sender: UIButton) {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                print("signed in as \(session?.userName)");
                let twitterClient = TWTRAPIClient(userID: session?.userID)
                twitterClient.loadUser(withID: (session?.userID)!, completion: { (user, error) in

                })
            }else {
                print("error: \(error?.localizedDescription)");
            }
        })
    }
    
    func redirectUserToHomeScreen()  {
    
    }
    
}
