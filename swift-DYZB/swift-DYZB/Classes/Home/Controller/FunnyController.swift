//
//  FunnyController.swift
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
class FunnyController: BaseController {
    
    
    fileprivate  lazy var funnyViewModel:FunnyViewModel = FunnyViewModel()
    
    
    fileprivate lazy var collectionView: UICollectionView = {
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置组的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, 10)
        layout.headerReferenceSize = .zero
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}

// MARK:- 设置UI
extension FunnyController{
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        collectionView.contentInset = UIEdgeInsetsMake(8, 0, 0, 0)
        collectionView.isHidden = true
    }
}

extension FunnyController{
    fileprivate func loadData(){
        funnyViewModel.loadFunnyData {
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.stopAnimImageView()
            
        }
    }
}

// MARK:- UICollectionViewDelegate协议
extension FunnyController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return funnyViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funnyViewModel.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath) as! CollectionNormalCell
        cell.anchor = funnyViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerveiw
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
       
        return headerView
    }
}


