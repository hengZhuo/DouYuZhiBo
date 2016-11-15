//
//  PageContentView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/14.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

private let contentCell : String = "contentCell"

class PageContentView: UIView {

    // MARK:- 定义属性
    fileprivate var childVcs:[UIViewController]
    fileprivate weak var parentViewController:UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    //禁止滚动
    fileprivate var isForbidScrollDelegate : Bool = false
    // MARK:- 懒加载
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //滚动方向
        layout.scrollDirection = .horizontal
        //2.创建collection
        let conllectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        conllectionView.showsHorizontalScrollIndicator = false
        conllectionView.bounces = false
      
        conllectionView.isPagingEnabled = true
        conllectionView.dataSource = self
        conllectionView.delegate = self

        conllectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCell)
         return conllectionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect,childVcs:[UIViewController],parentViewController:UIViewController?) {
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
        parentViewController?.addChildViewController(childVc)
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
// MARK:- UICollectionViewDelegate的协议
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
       startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollDelegate {return}
        
        //1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //如果完全滑过去了
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        print(progress)
        //3.将参数传入给titleView
       delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex:Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}




