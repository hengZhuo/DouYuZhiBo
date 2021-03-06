//
//  CollectionBeautifulCell.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/15.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBeautifulCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    //定义模型属性
    var anchor : AnchorModel?{
        didSet{
            //1.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            //2.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = String(format: "%.1f", CGFloat(anchor.online) / CGFloat(10000))
                onlineStr = "\(onlineStr)万人在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineLabel.text = onlineStr
            //3.昵称显示
            nickNameLabel.text = anchor.nickname
            //4.所在城市
            cityButton.setTitle(anchor.anchor_city, for: .normal)
            //5.图片
            guard let iconUrl = URL(string:anchor.vertical_src) else {
                return
            }
            photoImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named:"live_cell_default_phone"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.layer.cornerRadius = 5
        photoImageView.layer.masksToBounds = true
        onlineLabel.layer.cornerRadius = 3
        onlineLabel.layer.masksToBounds = true
        onlineLabel.isHighlighted = true
        onlineLabel.highlightedTextColor = UIColor.white
        
    }

}
