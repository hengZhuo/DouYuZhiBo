//
//  PageTitleView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/14.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class{
    func pageTitleView(titleView:PageTitleView,selectedIndex index : Int)
}

private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {

    // MARK:- 定义属性
    fileprivate var currentIndex:Int = 0
  fileprivate var titles : [String]
   fileprivate lazy var titleArray : [UILabel] = [UILabel]()
    weak var delegate : PageTitleViewDelegate?
    
    // MARK:- 懒加载
   fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //水平的线
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        //分页
        scrollView.isPagingEnabled = false
        //不能超过内容的范围
        scrollView.bounces = false
        return scrollView
    }()
    
   fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
  // MARK:- 自定义构造函数
    init(frame: CGRect, title:[String]) {
        self.titles = title
        super.init(frame: frame)
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面
extension PageTitleView{
    fileprivate func setupUI(){
        //1.添加scrollView
        self.addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加title对应的label
        setupTitleLabel()
        //3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    private func setupTitleLabel(){
        for (index,item) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            //2.设置Label的属性
            label.tag = index
            label.text = item
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            //3.设置label的frame
            let labelW : CGFloat = frame.width / CGFloat(titles.count)
            let labelH : CGFloat = frame.height - kScrollLineH
            let labelX : CGFloat = labelW * CGFloat(index)
            let labelY : CGFloat = 0
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleArray.append(label)
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
        
    }
    
    private func setupBottomLineAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        //2.添加scorllViewLine
        guard let firstLabel = titleArray.first else {
            return
        }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

// MARK:- 监听label的点击
extension PageTitleView{
  @objc fileprivate func titleLabelClick(tapGes:UITapGestureRecognizer) {
      //1.获取当前label的下标值
    guard let currentLabel = tapGes.view as? UILabel else{return}
    if currentLabel.tag == currentIndex {
        return
    }
    //2.获取之前的label
    let oldLabel = titleArray[currentIndex]
    //3.切换文字颜色
    currentLabel.textColor = UIColor.orange
    oldLabel.textColor = UIColor.darkGray
    //4.保存最新的label的下标值
    currentIndex = currentLabel.tag
    //5.滚动条的位置变化
    let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
    UIView.animate(withDuration: 0.15, animations:{
        self.scrollLine.frame.origin.x = scrollLineX
    })
    //6.通知代理
    delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageTitleView{
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //1.取出label
        let sourceLabel = titleArray[sourceIndex]
        let targetLabel = titleArray[targetIndex]
        //2.处理滑块的逻辑
        let moveToTalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveToTalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //3.颜色的渐变
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //记录最新的Index
        currentIndex = targetIndex
    }
}


