//
//  HomeController.swift
//  swift-DYZB
//
//  Created by chenrin on 2016/11/14.
//  Copyright © 2016年 zhuoheng. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40


class HomeController: UIViewController {

    // MARK:- 懒加载
   fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
    let titles = ["推荐","游戏","娱乐","趣玩"]
        let frame = CGRect(x: 0, y:kStatusBarH + kNavgationBarH , width: UIScreen.main.bounds.size.width, height: kTitleViewH)
        let titleView = PageTitleView(frame: frame, title: titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    lazy var pageContentView: PageContentView = {[weak self] in
            let contentH = kScreenH - kStatusBarH - kNavgationBarH - kTitleViewH - kTabBarH
            let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavgationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendController())
        childVcs.append(GameController())
        childVcs.append(AmuseController())
        childVcs.append(FunnyController())
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        
        return contentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
         setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeController{
    fileprivate func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        //1.设置导航栏
        setupNavBar()
        //2.添加titleView
        view.addSubview(pageTitleView)
        //3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.white
    }
    
   private func setupNavBar() {
    //1.设置左侧的item
     let btn = UIButton()
    btn.setImage(UIImage(named:"logo"), for: .normal)
    btn.sizeToFit()
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    //2.设置右侧的item
    let size = CGSize(width: 40, height: 40)
    let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
    let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
   // let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
    let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
    navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}

// MARK:- PageTitleViewDelegate代理
extension HomeController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
// MARK:- PageContentViewDelegate代理
extension HomeController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


