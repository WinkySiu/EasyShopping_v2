//
//  ShopProfileViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 26/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ShopProfileViewController: UIViewController {

    @IBOutlet weak var veView: UIVisualEffectView!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interfaceInit()
    }
    
    func interfaceInit() {
        veView.layer.masksToBounds = true
        veView.layer.cornerRadius = (veView?.frame.size.width)!/8
        bgImageView.layer.masksToBounds = true
        bgImageView.layer.cornerRadius = (veView?.frame.size.width)!/8
        shopImage?.layer.masksToBounds = true
        shopImage?.layer.cornerRadius = (shopImage?.frame.size.width)!/2
    }
    
    @IBAction func closeOnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func followOnClick(_ sender: Any) {
        print(123)
    }
    
    @IBAction func mapOnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Shop", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopMap") as! ShopMapViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func listOnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Shop", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopList") as! ShopListViewController
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
    }
    
    @IBAction func forumOnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Shop", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopForum") as! ShopForumViewController
        self.present(vc, animated: true)
    }

    
}
