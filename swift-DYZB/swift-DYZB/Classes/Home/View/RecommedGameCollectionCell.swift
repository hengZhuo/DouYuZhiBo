//
//  RecommedGameCollectionCell.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/18.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit
import Kingfisher

class RecommedGameCollectionCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
   
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            let iconUrl = URL(string: group?.icon_url ?? "")
            photoImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named:"home_more_btn"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoImageView.layer.cornerRadius = 22.5
        self.photoImageView.layer.masksToBounds = true
    }
    
   

}
