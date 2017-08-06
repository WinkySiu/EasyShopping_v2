//
//  ArticleViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 28/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    var article = ArticleObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interfaceInit()
        
    }

    func interfaceInit(){
        self.view.backgroundColor = ShareManager.sharedInstance.mainColor
        bgView.layer.masksToBounds = true
        bgView.layer.cornerRadius = (bgView?.frame.size.width)!/8
    }

}
