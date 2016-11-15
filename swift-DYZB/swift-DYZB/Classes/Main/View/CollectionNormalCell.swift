//
//  CollectionNormalCell.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/15.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
       photoImageView.layer.cornerRadius = 5
        photoImageView.layer.masksToBounds = true
    }

}
