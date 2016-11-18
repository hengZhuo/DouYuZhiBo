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
    @IBOutlet weak var nickNameLabel: UILabel!

    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    
    var anchor : AnchorModel?{
        didSet{
            guard let anchor = anchor else {
                return
            }
            var onlineStr = ""
            if anchor.online >= 1000 {
                onlineStr = String(format: "%.1f", CGFloat(anchor.online) / CGFloat(10000))
                onlineStr = "\(onlineStr)万人在线"
            }else{
                onlineStr = "\(anchor.online)人在线"
            }
            //人数
            onlineButton.setTitle(onlineStr, for: .normal)
            //名字
            nickNameLabel.text = anchor.nickname
            //房间号
            roomNameLabel.text = anchor.room_name
             guard let iconUrl = URL(string:anchor.vertical_src) else {
            return
        }
        photoImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named:"Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       photoImageView.layer.cornerRadius = 5
        photoImageView.layer.masksToBounds = true
        nickNameLabel.shadowColor = UIColor.black
        nickNameLabel.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
