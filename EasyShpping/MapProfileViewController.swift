//
//  MapProfileViewController.swift
//  EasyShpping
//
//  Created by Winky_swl on 25/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit

class MapProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let cancelButton = UIButton(frame: CGRect(x: 15.0, y: 25.0, width: 25, height: 25))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        cancelButton.layer.shadowColor = UIColor.black.cgColor
        cancelButton.layer.shadowOpacity = 5
        cancelButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        cancelButton.layer.shadowOpacity = 0.5
        self.view.addSubview(cancelButton)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
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
