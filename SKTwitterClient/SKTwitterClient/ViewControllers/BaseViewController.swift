//
//  BaseViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    class func instance()->UIViewController{
        assert(false, "This method must be overriden by the subclass")
    }
    
}
