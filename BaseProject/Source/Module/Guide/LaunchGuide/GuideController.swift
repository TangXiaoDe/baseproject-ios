//
//  GuideController.swift
//  ProjectTemplate-Swift
//
//  Created by 小唐 on 2018/11/27.
//  Copyright © 2018 TangXiaoDe. All rights reserved.
//
//  引导页 - 加载引导图

import UIKit

//  引导页
class GuideController: BaseViewController {
    // MARK: - Internal Property

    // MARK: - Private Property
    /// 引导滚动视图
    fileprivate let scrollView: UIScrollView = UIScrollView()
    /// 分页
    fileprivate let pageControl: UIPageControl = UIPageControl()
    /// 跳过按钮
    fileprivate let skipBtn: UIButton = UIButton(type: .custom)
    /// 进入按钮 - 立即体验
    fileprivate let enterBtn: UIButton = UIButton(type: .custom)

    /// 引导页总数
    fileprivate let pageCount: Int = 2

    // MARK: - Initialize Function

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal Function

// MARK: - LifeCircle Function
extension GuideController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUI()
        self.initialDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - UI
extension GuideController {
    /// 页面布局
    fileprivate func initialUI() -> Void {
        self.view.backgroundColor = AppColor.pageBg

        let enterBtnW: CGFloat = 120
        let enterBtnH: CGFloat = 40
        let centerYBottomMargin: CGFloat = 62 + kBottomHeight + enterBtnH * 0.5
        let skipBtnRightMargin: CGFloat = 30
        let skipBtnH: CGFloat = 30
        // 1. scrollView
        self.view.addSubview(self.scrollView)
        self.scrollView.frame = self.view.bounds
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        //self.scrollView.bounces = false
        // 2. pageControl
        self.view.addSubview(self.pageControl)
        self.pageControl.hidesForSinglePage = true
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        let pageCenterXConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.pageControl, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let pageCenterYConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.pageControl, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -centerYBottomMargin)
        let pageHeightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.pageControl, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 15)
        self.view.addConstraints([pageCenterXConstraint, pageCenterYConstraint])
        self.pageControl.addConstraints([pageHeightConstraint])
        // 3. enterBtn
        self.view.addSubview(self.enterBtn)
        self.enterBtn.setTitleColor(UIColor.init(hex: 0xF4CF4B), for: .normal)
        self.enterBtn.setTitle("立即开启", for: .normal)
        self.enterBtn.titleLabel?.font = UIFont.pingFangSCFont(size: 18, weight: .medium)
        self.enterBtn.addTarget(self, action: #selector(enterBtnClick(_:)), for: .touchUpInside)
        self.enterBtn.layer.cornerRadius = 5
        self.enterBtn.layer.masksToBounds = true
        self.enterBtn.layer.borderWidth = 1
        self.enterBtn.layer.borderColor = UIColor.init(hex: 0xF4CF4B).cgColor
        self.enterBtn.translatesAutoresizingMaskIntoConstraints = false
        let enterWidthConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.enterBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: enterBtnW)
        let enterHeightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.enterBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: enterBtnH)
        let enterCenterXConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.enterBtn, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let enterCenterYConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.enterBtn, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1, constant: -centerYBottomMargin)
        self.enterBtn.addConstraints([enterWidthConstraint, enterHeightConstraint])
        self.view.addConstraints([enterCenterXConstraint, enterCenterYConstraint])
        // 4. skipBtn
        self.view.addSubview(self.skipBtn)
        self.skipBtn.setTitle("跳过>>", for: .normal)
        self.skipBtn.setTitleColor(UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), for: .normal)
        self.skipBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.skipBtn.addTarget(self, action: #selector(enterBtnClick(_:)), for: .touchUpInside)
        self.skipBtn.translatesAutoresizingMaskIntoConstraints = false
        let skipCenterYConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.skipBtn, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.enterBtn, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let skipRightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.skipBtn, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -skipBtnRightMargin)
        let skipHeightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.skipBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: skipBtnH)
        self.skipBtn.addConstraints([skipHeightConstraint])
        self.view.addConstraints([skipCenterYConstraint, skipRightConstraint])
    }
}

// MARK: - Data(数据处理与加载)
extension GuideController {
    /// 默认数据加载
    fileprivate func initialDataSource() -> Void {
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = UIScreen.main.bounds.height
        // 加载images
        for index in 0..<self.pageCount {
            let imageView: UIImageView = UIImageView()
            self.scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: height)
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.image = self.getGuideImage(with: index)
        }
        self.scrollView.contentSize = CGSize(width: width * CGFloat(self.pageCount), height: height)
        // other
        self.pageControl.numberOfPages = self.pageCount
        self.pageControl.isHidden = true
        self.skipBtn.isHidden = true
        self.enterBtn.isHidden = true
    }
    fileprivate func getGuideImage(with index: Int) -> UIImage? {
        //let name: String = "IMG_bg_guide_" + "\(index)"
        let name: String
        if UIDevice.current.isiPhoneXRScreenSeries() {
            name = "IMG_bg_guide_xr_" + "\(index + 1)"
        } else {
            name = "IMG_bg_guide_6s_" + "\(index + 1)"
        }
        return UIImage(named: name)
    }
}

// MARK: - Event(事件响应)
extension GuideController {
    /// 跳过按钮点击
    @objc fileprivate func skipBtnClick(_ button: UIButton) -> Void {
        self.endGuide()
    }
    /// 进入按钮点击
    @objc fileprivate func enterBtnClick(_ button: UIButton) -> Void {
        self.endGuide()
    }
}

// MARK: - Notification
extension GuideController {

}

// MARK: - Extension Function
extension GuideController {
    /// 结束引导
    fileprivate func endGuide() -> Void {
        // 判断登录状态
        let isLogined: Bool = AccountManager.share.isLogin
        if isLogined {
            self.enterMainPage()
        } else {
            self.enterLoginPage()
        }
    }
    /// 进入登录页
    fileprivate func enterLoginPage() -> Void {
        RootManager.share.type = .login
    }
    /// 进入主页
    fileprivate func enterMainPage() -> Void {
        RootManager.share.type = .main
    }
}

// MARK: - Delegate Function

// MARK: - <UIScrollViewDelegate>
extension GuideController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取页数
        let offset = scrollView.contentOffset
        let page = lroundf(Float(offset.x / self.view.bounds.width))
        pageControl.currentPage = page
        // 特殊处理：跳过按钮，分页符，进入主页按钮；
        //let isLastPage: Bool = (page == self.pageCount - 1)
        //self.pageControl.isHidden = isLastPage
        //self.skipBtn.isHidden = isLastPage
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 获取页数
        let offset = scrollView.contentOffset
        let page = lroundf(Float(offset.x / self.view.bounds.width))
        // 特殊处理：进入主页按钮；
        let isLastPage: Bool = (page == self.pageCount - 1)
        self.enterBtn.isHidden = !isLastPage
    }
}
