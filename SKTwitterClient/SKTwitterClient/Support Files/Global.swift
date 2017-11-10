//
//  Global.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit
import STTwitter

let consumerKey = "liIM6ctHFzGDWH6qSa1TNsfEA"
let consumerSecret = "xn1aQ7sMknxdaHKTAccxPCyiKSRIRujhMw6lPs7cL9WZUy5R4t"

let delegate = UIApplication.shared.delegate as? AppDelegate

var appUser:UserModel?
var twitterClient:STTwitterAPI!


extension Notification.Name {
    static let TwitterAuthonticationSuccessNotification = Notification.Name("TwitterAuthonticationSuccess")
    static let TwitterAuthonticationFauilureNotification = Notification.Name("TwitterAuthonticationFail")
}

func replaceCurrentVisableViewControllerWithViewController(viewController:UIViewController)  {
    delegate?.window?.rootViewController = viewController
    delegate?.window?.makeKeyAndVisible()
}

func alertWithTitleInViewController(_ viewController:UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
    viewController.present(alert, animated: true, completion: nil)
}

extension URL {
    
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
}

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.characters.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}


extension UIView {
    
    @IBInspectable dynamic var  corner : CGFloat {
        get {
            return self.layer.cornerRadius //as NSNumber!
        }
        set {
            self.layer.cornerRadius = newValue //as CGFloat
            self.clipsToBounds = true
        }
        
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadiusView: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.35
            layer.shadowRadius = shadowRadiusView
            layer.masksToBounds = false
        }
    }
}


extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

let appBlueColor = UIColor(hexString: "#5DA8DCFF")
