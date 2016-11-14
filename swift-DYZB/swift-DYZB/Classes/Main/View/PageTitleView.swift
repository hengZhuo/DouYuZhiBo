//
//  PageTitleView.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/14.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {

    // MARK:- 定义属性
  fileprivate var titles : [String]
   fileprivate lazy var titleArray : [UILabel] = [UILabel]()
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
            label.textColor = UIColor.darkGray
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
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}





