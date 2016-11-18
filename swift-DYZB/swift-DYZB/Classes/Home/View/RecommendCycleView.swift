//
//  RecommendCycleView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/17.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let kCollectViewCell = "cell"

class RecommendCycleView: UIView {
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer : Timer?
    
    
    var cyclesModel : [CycleModel]?{
        didSet{
            self.collectionView.reloadData()
            //设置pageControlelr个数
            self.pageControl.numberOfPages = cyclesModel?.count ?? 0
            
            //默认滚动到中间某一个位置
            let indexPath = NSIndexPath(item: (cyclesModel?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            removeCycleTimer()
            //添加定时器
            addCycleTimer()
        }
    }
    
    // MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件拉伸和缩小
        autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        //注册cell
        
        collectionView.register(UINib(nibName: "CycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCollectViewCell)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.isPagingEnabled = true
        layout.scrollDirection = .horizontal
        //不显示滚动条
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

// MARK:- 提供一个类方法快速创建View
extension RecommendCycleView{
    class func recomendCycleView() -> RecommendCycleView{
        
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK:- UICollectionViewDataSource
extension RecommendCycleView : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cyclesModel?.count ?? 0) * 1000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectViewCell, for: indexPath) as! CycleCollectionCell
        
        let cycle = cyclesModel?[indexPath.item % cyclesModel!.count]
        
       cell.cycleModel = cycle
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的便宜量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cyclesModel?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
    
}


// MARK:-  对定时器的操作
extension RecommendCycleView{
    fileprivate func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 4.0, target: self, selector: #selector(sctollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer(){
        //从运行循环中移除
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
   @objc fileprivate func sctollToNext() {
        //获取滚动的偏移量
       let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
    //滚动到该位置
    collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    
    }
}



