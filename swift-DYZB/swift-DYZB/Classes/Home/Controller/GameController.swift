//
//  GameController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/18.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kGameCellID = "kGameCellID"
private let kHeaderCellH : CGFloat = 50
private let kHeaderCell = "kHeaderCell"

private let kGameViewH : CGFloat = 90

class GameController: BaseController {

    
    // MARK:- 懒加载
    
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -kHeaderCellH - kGameViewH, width: kScreenW, height: kHeaderCellH)
        headerView.titleLabel.text = "常见"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreButton.isHidden = true
        return headerView
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameVeiw = RecommendGameView.recommendGameView()
        gameVeiw.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
       return gameVeiw
    }()
   fileprivate lazy var gameViewModel: GameViewModel = GameViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderCellH)
        //2.创建collectionView
       let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
     collectionView.register(UINib(nibName: "RecommedGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderCell)
        collectionView.dataSource = self
        //大小随着父控件拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        return collectionView
    }()
    
    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
       
        
       
    }
}

// MARK:- 设置UI
extension GameController{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderCellH + kGameViewH, 0, 0, 0)
        collectionView.isHidden = true
    }
}

// MARK:- 请求数据
extension GameController{
    fileprivate func loadData(){
        gameViewModel.loadAllGameData {
            //展示全部游戏
            self.collectionView.reloadData()
            //展示常用的游戏
            self.gameView.gameGroup = self.gameViewModel.gameModels
            self.collectionView.isHidden = false
            self.stopAnimImageView()
        }
    }
}

// MARK:- UICollectionViewDataSource
extension GameController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderCell, for: indexPath) as! CollectionHeaderView
        
        headerView.titleLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreButton.isHidden = true
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! RecommedGameCollectionCell
       
        let gameModel = gameViewModel.gameModels[indexPath.item]
        
        cell.gameModel = gameModel
        
        return cell
    }
    
}





