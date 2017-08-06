//
//  SearchViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 22/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var imageArray = ["sh1", "sh2", "sh3", "sh4", "sh5", "sh6", "sh7"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    var searchController : UISearchController!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //Set tabBarItem image
        self.navigationController?.tabBarItem.selectedImage = UIImage(named: "SearchClicked")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationController?.tabBarItem.image = UIImage(named: "Search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SearchBar()
        
       
        
    }
    
    func SearchBar(){
        let layout = UICollectionViewFlowLayout()
        
        // 設置 section 的間距 四個數值分別代表 上、左、下、右 的間距
        layout.sectionInset = UIEdgeInsetsMake(4, 0, 4, 0);
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        collectionView.collectionViewLayout = layout
        
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 60/255, green: 196/255, blue: 211/255, alpha: 1)
        
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.searchBar.tintColor = UIColor(colorLiteralRed: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = searchController.searchBar
        
        self.definesPresentationContext = true
        
        for subView in searchController.searchBar.subviews {
            
            for subViewOne in subView.subviews {
                
                if let textField = subViewOne as? UITextField {
                    
//                    subViewOne.backgroundColor = UIColor.red
                    
                    //use the code below if you want to change the color of placeholder
                    let textFieldInsideUISearchBarLabel = textField.value(forKey: "placeholderLabel") as? UILabel
                    textFieldInsideUISearchBarLabel?.textColor = UIColor(colorLiteralRed: 142/255, green: 142/255, blue: 147/255, alpha: 1)
                }
            }
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    --------------------------- CollectionView ---------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row % 5) < 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SearchCollectionViewCell
            cell.imageView.image = UIImage(named: imageArray[indexPath.row])
            cell.imageView.layer.insertSublayer(addLayer(imageView: cell.imageView, index: 2), at: 0)
            
            return cell
        }
        else if (indexPath.row % 5) > 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SearchCollectionViewCell
            cell.imageView.image = UIImage(named: imageArray[indexPath.row])
            cell.imageView.layer.insertSublayer(addLayer(imageView: cell.imageView, index: 3), at: 0)
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SearchCollectionViewCell
            cell.imageView.image = UIImage(named: imageArray[indexPath.row])
            cell.imageView.layer.insertSublayer(addLayer(imageView: cell.imageView, index: 2), at: 0)
            cell.imageView.layer.insertSublayer(addLayer(imageView: cell.imageView, index: 2), at: 0)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let w = Double(UIScreen.main.bounds.size.width)
        
        if (indexPath.row % 5) < 2 {
            // 0.5 = (0 + 1 + 0) / 2
            return CGSize(width: w/2 - 0.5, height: (w/2 - 1.0) * 1.3)
        }
        else if (indexPath.row % 5) > 1 {
            // 0.666 = (0 + 1 + 1 + 0) / 3
            return CGSize(width: w/3 - 0.8, height: (w/3 - 1.0) * 1.3)
        }
        else {
            return CGSize(width: w/2 - 0.5, height: (w/2 - 1.0) * 1.3)
        }
    }
    
    func addLayer(imageView: UIImageView, index: Int) -> CAGradientLayer {
        imageView.layer.sublayers?.removeAll()
        let w = Double(UIScreen.main.bounds.size.width)
        
        let color1 = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0).cgColor
        let color2 = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0).cgColor
        let color3 =  UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.7).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2, color3]
        gradientLayer.locations = [ 0.0, 0.4, 1.0]
        
        gradientLayer.frame = CGRect(x: 0.0 , y: 0.0 , width: w/2 - 5, height: Double((w / CDouble(index) - 1) * 1.3))
        
        
        return gradientLayer
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("123")
        
    }
}
