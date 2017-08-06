//
//  ShareManager.swift
//  EasyShpping
//
//  Created by Winky_swl on 26/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ShareManager {
    
    var shopList = [ShopObject]()
    
    
    let mainColor = UIColor(colorLiteralRed: 60/255, green: 196/255, blue: 211/255, alpha: 1)
    let textColor = UIColor(displayP3Red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    
    static let sharedInstance = ShareManager()
}
