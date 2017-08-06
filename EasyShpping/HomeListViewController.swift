//
//  HomeListViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 22/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import AlamofireImage

class HomeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    var ref: DatabaseReference!
    
    var shopList = [ShopObject]()
    var imageArray = ["i2-1", "i2-2", "i2-3", "i2-4", "i2-5", "i2-6", "i2-7", "i2-1", "i2-2", "i2-3", "i2-4", "i2-5", "i2-6", "i2-7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableViewInit()
        getShopData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewInit() {
        listTableView.separatorStyle = .none
        listTableView.showsVerticalScrollIndicator = false
    }
    
    func getShopData() {
        ref = Database.database().reference().child("Shop")
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                //clearing the list
                self.shopList.removeAll()
                
                //iterating through all the values
                for data in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    //getting values
                    let dataObject = data.value as? [String: AnyObject]
                    
                    let shopTemp = ShopObject()
                    shopTemp.id = data.key
                    shopTemp.longitude  = Double((dataObject?["longitude"] as? String)!)
                    shopTemp.latitude = Double((dataObject?["latitude"] as? String)!)
                    shopTemp.name = dataObject?["name"] as? String
                    shopTemp.address = dataObject?["address"] as? String
                    shopTemp.imageurl = dataObject?["imageurl"] as? String
                    
//                    print(shopTemp.latitude)
//                    print(shopTemp.longitude)
//                    print(shopTemp.name)
//                    print(shopTemp.address)
//                    print(shopTemp.imageurl)
//                    print(shopTemp.id)
                    
                    self.shopList.append(shopTemp)
                }
                self.listTableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    //    --------------------------- TableView ---------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Shop", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopProfile") as! ShopProfileViewController
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeListTableViewCell
        
        
//        cell.listImageView?.image = UIImage(named: imageArray[indexPath.row])
        cell.configureCell(with: shopList[indexPath.row].imageurl!)
        cell.listImageView.layer.sublayers?.removeAll()
        
        let w = Double(cell.bounds.width)
        let h = Double(cell.bounds.height)
        let color1 = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0).cgColor
        let color2 = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0).cgColor
        let color3 =  UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.7).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1, color2, color3]
        gradientLayer.locations = [ 0.0, 0.4, 1.0]
        gradientLayer.frame = CGRect(x: 0.0 , y: 0.0 , width: w, height: h)
        
        cell.listImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.nameLabel.text = shopList[indexPath.row].name
        cell.addressLabel.text = shopList[indexPath.row].address
        
        return cell
    }
}
