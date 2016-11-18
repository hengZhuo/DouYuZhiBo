//
//  CycleCollectionCell.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/17.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

class CycleCollectionCell: UICollectionViewCell {

    // MARK:- 定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let iconUrl = URL(string: cycleModel?.pic_url ?? "")
            photoImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named:"Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       titleLabel.isHighlighted = true
        titleLabel.highlightedTextColor = UIColor.white
        titleLabel.shadowColor = UIColor.black
        titleLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
