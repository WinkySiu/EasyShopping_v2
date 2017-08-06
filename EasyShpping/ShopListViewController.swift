//
//  ShopListViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 30/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ShopListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imageArray = ["s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11", "s12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        interfaceInit()
    }
    
    func interfaceInit() {
        self.navigationController?.navigationBar.barTintColor = ShareManager.sharedInstance.mainColor
        navigationItem.title = "H:CONNECT"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let right_menu_button = UIBarButtonItem(image: UIImage(named: "sort")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                               style: UIBarButtonItemStyle.plain ,
                                               target: self, action: #selector(filterOnClick))
        self.navigationItem.rightBarButtonItem  = right_menu_button
        
        let left_menu_button = UIBarButtonItem(image: UIImage(named: "multiply")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                                style: UIBarButtonItemStyle.plain ,
                                                target: self, action: #selector(cancelOnClick))
        self.navigationItem.leftBarButtonItem  = left_menu_button
        
        let layout = UICollectionViewFlowLayout()
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.collectionViewLayout = layout
    }
    
    func filterOnClick() {
        print(123)
    }
    
    func cancelOnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Shop", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopItem") as! ShopItemViewController
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated:true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ShopListCollectionViewCell
        cell.itemImage.image = UIImage(named: imageArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let w = Double(UIScreen.main.bounds.size.width)
        
        return CGSize(width: w/3 - 0.8, height: (w/3 - 0.8) * 1.3 )
    }
    
}
