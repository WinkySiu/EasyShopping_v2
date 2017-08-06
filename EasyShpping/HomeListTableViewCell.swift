//
//  HomeListTableViewCell.swift
//  EasyShpping
//
//  Created by Winky_swl on 25/7/2017.
//  Copyright © 2017年 Winky_swl. All rights reserved.
//

import UIKit
import SDWebImage

class HomeListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureCell(with URLString: String) {
        
        listImageView.sd_setImage(
            with: URL(string: URLString)!,
            placeholderImage: UIImage(named: "loading")
        )
    }
}
