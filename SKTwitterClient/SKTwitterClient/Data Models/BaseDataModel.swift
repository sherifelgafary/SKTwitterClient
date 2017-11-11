//
//  BaseDataModel.swift
//  SKTwitterClient
//
//  Created by sherif Khaled on 11/9/17.
//  Copyright © 2017 SherifKhaled. All rights reserved.
//

import UIKit

class BaseDataModel: NSObject {
    
    class func getModelObjectFromAPIDictionary(dataDictionary:[String:AnyObject]) -> BaseDataModel{
        assert(false, "This method must be overriden by the subclass")
    }

}
