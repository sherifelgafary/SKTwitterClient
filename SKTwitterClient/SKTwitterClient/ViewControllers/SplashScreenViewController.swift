//
//  SplashScreenViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

class SplashScreenViewController: BaseViewController {

    @IBOutlet weak var twitterIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        replaceCurrentVisableViewControllerWithViewController(viewController: LoginViewController.instance())
    }
    
}
