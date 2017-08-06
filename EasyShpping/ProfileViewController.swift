//
//  ProfileViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 22/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    var profileImage: UIImageView?
    var bgImageView: UIImageView?
    var functionView: UIView?
    var listButton: UIButton?
    var mapButton: UIButton?
    var collectionButton: UIButton?
    @IBOutlet weak var collectionView: UICollectionView!
    
    var functionChoice: Bool = true
    var chooseView: UIView?
    var w: Double?
    
    var imageArray = ["s1", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11", "s12"]
    var shopArray = ["sh1", "sh2", "sh3", "sh4", "sh5", "sh6", "sh7"]
    var tempArray = [String]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Set tabBarItem image
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "ProfileClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationController?.tabBarItem.image = UIImage(named: "Profile")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tempArray = imageArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        interfaceInit()
    }
    
    func interfaceInit() {
        navigationItem.title = "Catherine_Chan"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 60/255, green: 196/255, blue: 211/255, alpha: 1)
        
//        ------------------------ Collection View Setting -------------------------
        
        let layout = UICollectionViewFlowLayout()
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 4, 0);
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView.collectionViewLayout = layout    

        
        
    }
    
    func listOnClick() {
        UIView.animate(withDuration: 0.5) {
            self.chooseView?.frame.origin.x = 0
        }
        buttonImage(index: 0)
        functionChoice = true
        tempArray.removeAll()
        tempArray = imageArray
        collectionView.reloadData()
    }
    
    func mapButtonOnClick() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapProfile") as! MapProfileViewController
        present(vc, animated: true, completion: nil)
    }

    func collectionOnClick() {
        UIView.animate(withDuration: 0.5) {
            let w = UIScreen.main.bounds.width
            self.chooseView?.frame.origin.x = w - (self.chooseView?.frame.width)!
        }
        buttonImage(index: 1)
        functionChoice = false
        tempArray.removeAll()
        tempArray = shopArray
        collectionView.reloadData()
    }
    
    func buttonImage(index: Int) {
        switch index {
        case 0:
            listButton?.setImage(#imageLiteral(resourceName: "6").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            collectionButton?.setImage(#imageLiteral(resourceName: "1").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        case 1:
            listButton?.setImage(#imageLiteral(resourceName: "5").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            collectionButton?.setImage(#imageLiteral(resourceName: "2").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        default:
            listButton?.setImage(#imageLiteral(resourceName: "6"), for: .normal)
            collectionButton?.setImage(#imageLiteral(resourceName: "1"), for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProfileCollectionViewCell
        imageCell.imageView.image = UIImage(named: tempArray[indexPath.row])
            
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let w = Double(UIScreen.main.bounds.size.width)

        return CGSize(width: w/3 - 0.8, height: w/3 - 0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath as IndexPath)
        
        bgImageView = cell.viewWithTag(1) as! UIImageView
        bgImageView?.image = #imageLiteral(resourceName: "i2-4")
        
        profileImage = cell.viewWithTag(2) as! UIImageView
        profileImage?.image = #imageLiteral(resourceName: "i2-4")
        profileImage?.layer.masksToBounds = true
        profileImage?.layer.cornerRadius = (profileImage?.frame.size.width)!/2
        
        functionView = cell.viewWithTag(3)!
        functionView?.layer.shadowColor = UIColor.black.cgColor
        functionView?.layer.shadowOpacity = 5
        functionView?.layer.shadowOffset = CGSize(width: 0, height: 2)
        functionView?.layer.shadowOpacity = 0.3
        
        if (functionView?.layer.sublayers?.count)! < 4 {
            let w = Double(UIScreen.main.bounds.size.width)
            chooseView = UIView(frame: CGRect(x: 0, y: 47.5, width: w / 3 - 0.8, height: 2.5))
            chooseView?.backgroundColor = UIColor(colorLiteralRed: 60/255, green: 196/255, blue: 211/255, alpha: 1)
            functionView?.addSubview(chooseView!)
        }
        
        listButton = cell.viewWithTag(4) as! UIButton
        
        listButton?.addTarget(self, action: #selector(listOnClick), for: .touchUpInside)
        
        mapButton = cell.viewWithTag(5) as! UIButton
        mapButton?.setImage(#imageLiteral(resourceName: "3").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        mapButton?.addTarget(self, action: #selector(mapButtonOnClick), for: .touchUpInside)
        
        collectionButton = cell.viewWithTag(6) as! UIButton
        collectionButton?.addTarget(self, action: #selector(collectionOnClick), for: .touchUpInside)
        
        if functionChoice == true {
            listButton?.setImage(#imageLiteral(resourceName: "6").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            collectionButton?.setImage(#imageLiteral(resourceName: "1").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        } else {
            listButton?.setImage(#imageLiteral(resourceName: "5").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            collectionButton?.setImage(#imageLiteral(resourceName: "2").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let w = Double(UIScreen.main.bounds.size.width)
        return CGSize(width: w, height: 304)
    }
    
}
