//
//  PageContentView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/14.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let contentCell : String = "contentCell"

class PageContentView: UIView {

    // MARK:- 定义属性
    fileprivate var childVcs:[UIViewController]
    fileprivate var parentViewController:UIViewController
    
    // MARK:- 懒加载
    fileprivate lazy var collectionView: UICollectionView = {
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //滚动方向
        layout.scrollDirection = .horizontal
        //2.创建collection
        let conllectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        conllectionView.showsHorizontalScrollIndicator = false
        conllectionView.bounces = false
        conllectionView.isPagingEnabled = false
        conllectionView.dataSource = self
        conllectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCell)
         return conllectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageContentView{
   fileprivate func setupUI() {
        //1.将所有的子控制器添加到父控制中
    for childVc in childVcs {
        parentViewController.addChildViewController(childVc)
    }
        //2.添加UICollectionView，用于在cell中存放控制器的View
    addSubview(collectionView)
    collectionView.frame = bounds
    }
}

// MARK:- 遵守UICollectionViewDataSource协议
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCell, for: indexPath)
        
        //2.给cell设置内容
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}





