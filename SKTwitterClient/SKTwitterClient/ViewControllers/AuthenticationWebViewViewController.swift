//
//  AuthenticationWebViewViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

class AuthenticationWebViewViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override class func instance()->AuthenticationWebViewViewController{
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: "AuthenticationWebViewViewController") as! AuthenticationWebViewViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func CancelAuthontication(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            dissmissLoader()
        }
    }
}
