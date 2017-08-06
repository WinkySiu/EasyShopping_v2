//
//  HomeViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 22/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var area = UIButton()
    var food = UIButton()
    var sport = UIButton()
    var life = UIButton()
    var fun = UIButton()
    var all = UIButton()
    var blackview  :UIView?
    var cates = "全部"
    var buttonview: UIView?
    
    @IBOutlet weak var MapView: UIView!
    @IBOutlet weak var ListView: UIView!
    var right_menu_button: UIBarButtonItem!
    var viewChangre = false
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Set tabBarItem image
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "HomeClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationController?.tabBarItem.image = UIImage(named: "Home")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NavigationBarSetting()
        
        MapView.isHidden = false
        ListView.isHidden = true
        
    }
    
    
    func NavigationBarSetting() {
        let logo = UIImage(named: "EasyShopping")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.barTintColor = ShareManager.sharedInstance.mainColor
        right_menu_button = UIBarButtonItem(image: UIImage(named: "grid")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                                style: UIBarButtonItemStyle.plain ,
                                                target: self, action: #selector(OnMenuClicked(sender:)))
        
        self.navigationItem.rightBarButtonItem = right_menu_button
        
        let left_menu_button = UIBarButtonItem(image: UIImage(named: "sort")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                               style: UIBarButtonItemStyle.plain ,
                                               target: self, action: #selector(addcategory))
        self.navigationItem.leftBarButtonItem  = left_menu_button
        setbuttongroup()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func OnMenuClicked(sender: UIButton!) {
        switch viewChangre
        {
        case true:
            MapView.isHidden = false
            ListView.isHidden = true
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "grid")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            self.viewChangre = false
        case false:
            MapView.isHidden = true
            ListView.isHidden = false
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "map")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            self.viewChangre = true
        }
    }

    
    //分類
    func setbuttongroup(){
        
        
        let fullscreen = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        blackview = UIView(frame: fullscreen)
        blackview?.backgroundColor = UIColor(white: 0.15, alpha: 0.9)
        blackview?.alpha = 0
        
        buttonview = UIView(frame: fullscreen)
        buttonview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissblackview)))
        
        
        all = UIButton(frame: CGRect(x: (fullscreen.midX), y: 100, width: 100, height: 50))
        all.setTitle("全部", for: .normal)
        all.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        all.center.x = (fullscreen.midX)
        all.layer.cornerRadius = 5
        all.layer.borderWidth = 1
        all.layer.borderColor = UIColor.white.cgColor
        all.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        
        area = UIButton(frame: CGRect(x: (fullscreen.midX), y: 180, width: 100, height: 50))
        area.setTitle("地區", for: .normal)
        area.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        area.center.x = (fullscreen.midX)
        area.layer.cornerRadius = 5
        area.layer.borderWidth = 0
        area.layer.borderColor = UIColor.white.cgColor
        area.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        food = UIButton(frame: CGRect(x: (fullscreen.midX), y: 260, width: 100, height: 50))
        food.setTitle("美食", for: .normal)
        food.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        food.center.x = (fullscreen.midX)
        food.layer.cornerRadius = 5
        food.layer.borderWidth = 0
        food.layer.borderColor = UIColor.white.cgColor
        food.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        self.sport = UIButton(frame: CGRect(x: (fullscreen.midX), y: 340, width: 100, height: 50))
        sport.setTitle("運動", for: .normal)
        sport.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        sport.center.x = (fullscreen.midX)
        sport.layer.cornerRadius = 5
        sport.layer.borderWidth = 0
        sport.layer.borderColor = UIColor.white.cgColor
        sport.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        self.life = UIButton(frame: CGRect(x: (fullscreen.midX), y: 420, width: 100, height: 50))
        life.setTitle("生活", for: .normal)
        life.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        life.center.x = (fullscreen.midX)
        life.layer.cornerRadius = 5
        life.layer.borderWidth = 0
        life.layer.borderColor = UIColor.white.cgColor
        life.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        
        self.fun = UIButton(frame: CGRect(x: (fullscreen.midX), y: 500, width: 100, height: 50))
        fun.setTitle("有趣", for: .normal)
        fun.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        fun.center.x = (fullscreen.midX)
        fun.layer.cornerRadius = 5
        fun.layer.borderWidth = 0
        fun.layer.borderColor = UIColor.white.cgColor
        fun.addTarget(self, action: #selector(buttontap(sender:)), for: .touchUpInside)
        
        self.buttonview?.addSubview(all)
        self.buttonview?.addSubview(area)
        self.buttonview?.addSubview(food)
        self.buttonview?.addSubview(sport)
        self.buttonview?.addSubview(life)
        self.buttonview?.addSubview(fun)
        
        
        //self.buttonview?.backgroundColor = UIColor.blue
        self.buttonview?.alpha = 0
        
        //self.buttonview?.layer.shouldRasterize = true
        
        self.view.addSubview(buttonview!)
        self.view.addSubview(blackview!)
    }
    
    func addcategory(){
        
        self.view.bringSubview(toFront: buttonview!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.blackview?.alpha = 1
            self.buttonview?.alpha = 1
        })
        
    }
    
    func buttontap(sender: Any){
        
        let button =  sender as! UIButton
        all.layer.borderWidth = 0
        area.layer.borderWidth = 0
        food.layer.borderWidth = 0
        sport.layer.borderWidth = 0
        life.layer.borderWidth = 0
        fun.layer.borderWidth = 0
        button.layer.borderWidth = 1
        
        cates = button.titleLabel?.text as! String
        print(cates)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, animations: {
            self.blackview?.alpha = 0
            self.buttonview?.alpha = 0
        })
        
    }
    
    func dismissblackview(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackview?.alpha = 0
            self.buttonview?.alpha = 0
        })
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
