//
//  AmuseMenuView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/22.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let kMuseCellId = "kMuseCellId"

class AmuseMenuView: UIView {
   
    var groups : [AnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MeuseCollectionCell", bundle: nil), forCellWithReuseIdentifier: kMuseCellId)
    }
    //设置布局
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }

}

extension AmuseMenuView{
    class func loadAmuseMenuView()->AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {
            return 0
        }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageController.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMuseCellId, for: indexPath) as! MeuseCollectionCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell:MeuseCollectionCell,indexPath:IndexPath){
        //0页：0——7
        //1页：8——15
        //2页：16——23
        //1.取出起始位置和终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        //2.判断越界
        if endIndex > (groups?.count)! - 1 {
            endIndex = (groups?.count)! - 1
        }
        //取出数据
        cell.groups = Array(groups![startIndex...endIndex])
        
    }
    
}


