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
                onlineStr = "\(CGFloat(anchor.online / 10000))万人在线"
            }else{
                onlineStr = "\(anchor.online)人在线"
            }
            //人数
            onlineButton.setTitle(onlineStr, for: .normal)
            //名字
            nickNameLabel.text = anchor.nickname
            //房间号
            roomNameLabel.text = anchor.room_name
            //
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       photoImageView.layer.cornerRadius = 5
        photoImageView.layer.masksToBounds = true
    }

}
