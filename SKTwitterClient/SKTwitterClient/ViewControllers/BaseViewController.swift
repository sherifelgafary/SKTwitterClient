//
//  BaseViewController.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import RevealingSplashView

class BaseViewController: UIViewController {
    
    var splashIconSize:CGSize!
    var revealingSplashView : RevealingSplashView?
    var showSplashAnimation = false
    
    class func instance()->UIViewController{
        assert(false, "This method must be overriden by the subclass")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.showSplashAnimation{
            self.animateSplashView()
        }
        if let VC = self as? HomeViewController {
            if self.showSplashAnimation == false{
                VC.setupNavigationBarItems()
            }
        }
    }
    
    func animateSplashView()  {
        revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "twitterIcon")!,iconInitialSize: self.splashIconSize, backgroundColor: appBlueColor!)
        self.view.addSubview(revealingSplashView!)
        
        revealingSplashView?.animationType = SplashAnimationType.popAndZoomOut
        
        revealingSplashView?.startAnimation(){
            if let VC = self as? HomeViewController {
                VC.setupNavigationBarItems()
            }
            self.revealingSplashView?.removeFromSuperview()
            self.revealingSplashView = nil
        }

    }
    
    
    
}
