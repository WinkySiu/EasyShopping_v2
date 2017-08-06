//
//  ShopItemViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 30/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ShopItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var color1: UIView!
    @IBOutlet weak var color2: UIView!
    @IBOutlet weak var color3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interfaceInit()
    }
    
    func interfaceInit() {
        self.navigationController?.navigationBar.barTintColor = ShareManager.sharedInstance.mainColor
        navigationItem.title = "H:CONNECT"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let left_menu_button = UIBarButtonItem(image: UIImage(named: "multiply")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal),
                                               style: UIBarButtonItemStyle.plain ,
                                               target: self, action: #selector(cancelOnClick))
        self.navigationItem.leftBarButtonItem  = left_menu_button
        
        itemImage.image = UIImage(named: "s1")
        self.color1.layer.borderWidth = 1
        self.color1.layer.borderColor = UIColor(red:151/255.0, green:151/255.0, blue:151/255.0, alpha: 1.0).cgColor
        
        self.color2.layer.borderWidth = 1
        self.color2.layer.borderColor = UIColor(red:151/255.0, green:151/255.0, blue:151/255.0, alpha: 1.0).cgColor
        
        self.color3.layer.borderWidth = 1
        self.color3.layer.borderColor = UIColor(red:151/255.0, green:151/255.0, blue:151/255.0, alpha: 1.0).cgColor
        
        let layout = UICollectionViewFlowLayout()
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.collectionViewLayout = layout
        collectionView.isScrollEnabled = false
    }
    
    func cancelOnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ShopItemCollectionViewCell
        
        cell.image.image = UIImage(named: "s\(indexPath.row + 2)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let w = Double(UIScreen.main.bounds.size.width)
        let collection_height = collectionView.bounds.height
        
        return CGSize(width: w/3 - 2, height: Double(collection_height))
    }

    

}
