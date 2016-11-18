//
//  RecommendController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/15.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kBeautifulItemH = kItemW * 4 / 3
private let kCollectionCell = "kCollectionCell"
private let kBeautifulCell = "kBeautifulCell"
private let kHeaderViewH : CGFloat = 50
private let kHeaderViewID = "kHeaderViewID"
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendController: UIViewController {
    
    fileprivate lazy var recommendViewModel:RecommendViewModel = RecommendViewModel()
    
    // MARK:- 懒加载
    
    //轮播的View
    fileprivate lazy var cycleView : RecommendCycleView = {
       let cycleView = RecommendCycleView.recomendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
        
    }()
    //轮播游戏View
    fileprivate lazy var gameView : RecommendGameView = {
       
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x :0,y: -kGameViewH,width:kScreenW, height:90)
        return gameView
        
    }()
   fileprivate lazy var collectionView: UICollectionView = {
        //1.创建布局
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: kItemW, height: kItemH)
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = kItemMargin
    //设置组的内边距
    layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, 10)
    layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
    //2.创建UICollectionView
    let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor.white
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsHorizontalScrollIndicator = true
    collectionView.showsVerticalScrollIndicator = true
    collectionView.register((UINib(nibName: "CollectionHeaderView", bundle: nil)),forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
    collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil),forCellWithReuseIdentifier:kCollectionCell)
    collectionView.register(UINib(nibName: "CollectionBeautifulCell", bundle: nil),forCellWithReuseIdentifier:kBeautifulCell)
    
    //大小随着父控件拉伸而拉伸
    collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        return collectionView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
        loadData()
            }
}

// MARK:- 设置UI界面
extension RecommendController{
    fileprivate func setupUI(){
     view.backgroundColor = UIColor.purple
        //1.添加collectionView
        
        view.addSubview(collectionView)
        //添加无线轮播
        collectionView.addSubview(cycleView)
        
        //添加游戏的View
        collectionView.addSubview(gameView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
}

// MARK:- 请求数据
extension RecommendController{
    fileprivate func loadData(){
        
        //请求推荐数据
        recommendViewModel.requestData(){
            self.collectionView.reloadData()
            
            //将数据传递给gameView 
            self.gameView.group = self.recommendViewModel.anchorGroups
        }
        //请求轮播数据
        recommendViewModel.requesCycleData(){
            self.cycleView.cyclesModel = self.recommendViewModel.cycleModels
        }
    }
}



// MARK:- UICollectionViewDataSource协议
extension RecommendController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //item的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kBeautifulItemH)
        }else{
            return CGSize(width: kItemW, height: kItemH)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      let group = recommendViewModel.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 取出模型对象
        let group = recommendViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        
        
        if indexPath.section == 1 {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBeautifulCell, for: indexPath) as! CollectionBeautifulCell
            cell.anchor = anchor
             return cell
        }else{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath) as! CollectionNormalCell
             cell.anchor = anchor
             return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        header.backgroundColor = UIColor.white
        
        //取出模型
        let group = recommendViewModel.anchorGroups[indexPath.section]
        header.group = group
        
        return header
    }
    
}

