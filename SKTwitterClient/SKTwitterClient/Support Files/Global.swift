//
//  Global.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

let delegate = UIApplication.shared.delegate as? AppDelegate

func replaceCurrentVisableViewControllerWithViewController(viewController:UIViewController)  {
    delegate?.window?.rootViewController = viewController
    delegate?.window?.makeKeyAndVisible()
}
