//
//  AmuseController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/22.
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
private let kMenuView : CGFloat = 200

class AmuseController: BaseController {
    
    
    // MARK:- 懒加载
    
    fileprivate lazy var amuseMenueView:AmuseMenuView = {
        let meuView = AmuseMenuView.loadAmuseMenuView()
        meuView.frame = CGRect(x: 0, y: -kMenuView, width: kScreenW, height: kMenuView)
        return meuView
    }()
    
    fileprivate lazy var amuseViewModel:AmuseViewModel = AmuseViewModel()
    
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


// MARK:- 设置UI
extension AmuseController {
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.addSubview(amuseMenueView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuView, 0, 0, 0)
        collectionView.isHidden = true
    }
}

extension AmuseController{
    fileprivate func loadData(){
        amuseViewModel.loadAmuseData {
            self.collectionView.reloadData()
            var temGroup = self.amuseViewModel.anchorGroups
            temGroup.removeFirst()
            self.amuseMenueView.groups = temGroup
            self.collectionView.isHidden = false
            self.stopAnimImageView()
        }
    }
}


// MARK:- UICollectionViewDelegate协议
extension AmuseController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseViewModel.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath) as! CollectionNormalCell
        cell.anchor = amuseViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerveiw
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        headerView.group = amuseViewModel.anchorGroups[indexPath.section]
        return headerView
    }
}
