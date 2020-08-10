//
//  AdvertCustomBannerView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/14.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class AdvertCustomBannerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

////  [注1] 该轮播图有问题，先采用三方实现，之后自己实现。
//
//import UIKit
//
//class AdvertBannerView: UIView {
//
//    // MARK: - Internal Property
//
//    /// 视图切换时间间隔
//    var timerInterval: TimeInterval = 2
//    /// 动画开关
//    var autoAnimaiton = false
//
//    /// 是否显示分页指示器，默认不显示
//    var showPageControl: Bool = false {
//        didSet {
//            self.pageControl.isHidden = !showPageControl
//        }
//    }
//
//    var itemSize: CGSize = CGSize(width: kScreenWidth, height: 100)
//
//    var models: [AdvertModel] = [] {
//        didSet {
//            self.setupModels(models)
//        }
//    }
//
//    // MARK: - Private Property
//
//    fileprivate let mainView: UIView = UIView()
//    fileprivate let adverItemTagBase: Int = 250
//
//    /// 滚动视图
//    fileprivate let scrollView = UIScrollView(frame: CGRect.zero)
//    /// 分页指示器
//    fileprivate let pageControl = UIPageControl()
//
//    /// 计时器
//    fileprivate var timer: Timer? = nil
//    /// startTimer的计数标记，用于处理一些异常
//    fileprivate var startTimerFlag: Int = 0
//
//
//
//    // MARK: - Initialize Function
//    init() {
//        super.init(frame: CGRect.zero)
//        self.initialUI()
//    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.initialUI()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.initialUI()
//        //fatalError("init(coder:) has not been implemented")
//    }
//
//    deinit {
//        self.stopTimer()
//    }
//
//}
//
//// MARK: - Internal Function
//extension AdvertBannerView {
//    class func loadXib() -> AdvertBannerView? {
//        return Bundle.main.loadNibNamed("AdvertBannerView", owner: nil, options: nil)?.first as? AdvertBannerView
//    }
//
//    /// 启动动画
//    public func startAnimation() {
//        // 如果只有一张图片，就不滚动
//        if models.count < 2 {
//            scrollView.isScrollEnabled = false
//            return
//        }
//        scrollView.isScrollEnabled = true
//        autoAnimaiton = true
//        self.startTimer()
//    }
//
//    /// 停止动画
//    public func stopAnimation() {
//        autoAnimaiton = false
//        self.stopTimer()
//    }
//}
//
//// MARK: - LifeCircle Function
//extension AdvertBannerView {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.initialInAwakeNib()
//    }
//}
//// MARK: - Private UI 手动布局
//extension AdvertBannerView {
//
//    /// 界面布局
//    fileprivate func initialUI() -> Void {
//        self.addSubview(self.mainView)
//        self.initialMainView(self.mainView)
//        self.mainView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//    }
//    fileprivate func initialMainView(_ mainView: UIView) -> Void {
//        // scrollView
//        mainView.addSubview(self.scrollView)
//        self.scrollView.isPagingEnabled = true
//        self.scrollView.showsVerticalScrollIndicator = false
//        self.scrollView.showsHorizontalScrollIndicator = false
//        self.scrollView.delegate = self
//        self.scrollView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//        // pageControl
//        mainView.addSubview(self.pageControl)
//        self.pageControl.isHidden = true
//        self.pageControl.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.height.equalTo(15)
//        }
//    }
//
//}
//// MARK: - Private UI Xib加载后处理
//extension AdvertBannerView {
//    /// awakeNib时的处理
//    fileprivate func initialInAwakeNib() -> Void {
//
//    }
//}
//
//// MARK: - Data Function
//extension AdvertBannerView {
//    /// 设置广告的内容
//    fileprivate func setupModels(_ models: [AdvertModel]) {
//        self.scrollView.removeAllSubView()
//        self.pageControl.numberOfPages = 0
//        if models.isEmpty {
//            return
//        }
//        // scrollView
//        for (index, model) in models.enumerated() {
//            let itemView = AdvertBannerItemView()
//            self.scrollView.addSubview(itemView)
//            itemView.model = model
//            itemView.tag = self.adverItemTagBase + index
//            itemView.itemClickAction = { (_ itemView: AdvertBannerItemView, _ itemModel: AdvertModel) in
//
//            }
//            itemView.snp.makeConstraints { (make) in
//                make.top.bottom.equalToSuperview()
//                make.size.equalTo(self.itemSize)
//                let leftMargin: CGFloat = self.itemSize.width * CGFloat(index)
//                make.leading.equalToSuperview().offset(leftMargin)
//                if index == models.count - 1 {
//                    make.trailing.equalToSuperview()
//                }
//            }
//            // maskView
//
//        }
//        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//        // pageControl
//        self.pageControl.numberOfPages = models.count
//        self.pageControl.currentPage = 0
//    }
//}
//
//// MARK: - Event Function
//extension AdvertBannerView {
//
//}
//
//// MARK: - Extension Function
//extension AdvertBannerView {
//
//}
//
//// MARK: - Timer
//extension AdvertBannerView {
//    /// 停止计时器
//    fileprivate func stopTimer() {
//        self.timer?.invalidate()
//        self.timer = nil
//    }
//
//    /// 启动计时器
//    fileprivate func startTimer() {
//        self.stopTimer()
//        timer = XDPackageTimer.timerWithInterval(timerInterval: timerInterval, target: self, selector: #selector(switchAdvert), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
//        timer?.fire()
//    }
//
//    /// 广告切换
//    @objc fileprivate func switchAdvert() -> Void {
//        let itemW: CGFloat = self.itemSize.width
//        let nextIndex = Int(round(scrollView.contentOffset.x / itemW)) + 1
//        if nextIndex == models.count + 2 {
//            scrollView.setContentOffset(CGPoint(x: itemW, y: 0), animated: false)
//            scrollView.setContentOffset(CGPoint(x: 2 * itemW, y: 0), animated: true)
//        } else {
//            scrollView.setContentOffset(CGPoint(x: CGFloat(nextIndex) * itemW, y: 0), animated: true)
//        }
//    }
//
//}
//
//
//// MARK: - Delegate Function
//
//// MARK: - <UIScrollViewDelegate>
//extension AdvertBannerView: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let itemWidth: CGFloat = self.itemSize.width
//        let maxIndex = models.count + 1
//        let currentOffset = scrollView.contentOffset.x
//        let currentIndex = Int(round(scrollView.contentOffset.x / itemWidth))
//
//        // pageControl
//        if pageControl.currentPage == currentIndex {
//            return
//        }
//        if currentIndex == 0 {
//            pageControl.currentPage = models.count - 1
//        } else if currentIndex == maxIndex {
//            pageControl.currentPage = 0
//        } else {
//            pageControl.currentPage = currentIndex - 1
//        }
//        // scroll view
//        if currentOffset > CGFloat(maxIndex) * itemWidth { // 大于于倒数第二张时
//            scrollView.setContentOffset(CGPoint(x: itemWidth, y: 0), animated: false)
//        }
//        if currentOffset < frame.width {
//            scrollView.setContentOffset(CGPoint(x: CGFloat(maxIndex) * itemWidth, y: 0), animated: false)
//        }
//    }
//
//    // 滚动视图被拖拽
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        self.stopTimer()
//    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if !autoAnimaiton || nil == self.timer {
//            return
//        }
//        // 连续多次的滑动时，多次调用scrollViewDidEndDecelerating，多次调用startTimer，导致最后一次结束后会出现多次的快速滑动现象
//        self.startTimerFlag += 1
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.timerInterval, execute: {
//            self.startTimerFlag -= 1
//            if self.startTimerFlag == 0 {
//                self.startTimer()
//            }
//        })
//    }
//}
//
//
