//
//  RecommendGameView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/18.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let kCollectionCell = "kCollectionCell"


class RecommendGameView: UIView {
    // MARK:- 定义数据的属性
    var group:[AnchorGroup]?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    var gameGroup:[GameModel]?{
        didSet{
            var gps : [AnchorGroup] = [AnchorGroup]()
            
            for game in gameGroup! {
                let gp = AnchorGroup()
                gp.tag_name = game.tag_name
                gp.icon_url = game.icon_url
               gps.append(gp)
            }
           group = gps
            self.collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        //注册cell
        
        collectionView.register(UINib(nibName: "RecommedGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCollectionCell)
        
    }

}


// MARK:- 快速创建类方法
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath) as! RecommedGameCollectionCell
        cell.group = self.group![indexPath.item]
        return cell
    }
    
    
}


