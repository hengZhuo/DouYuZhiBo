//
//  CollectionHeaderView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/15.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK:- 定义模型属性
    var group : AnchorGroup?{
        didSet{
          
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: (group?.icon_name)!)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
