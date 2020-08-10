//
//  AdvertBannerView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  广告banner - 采用HQFlowView
//  左右间距、高度 应提取出来

import UIKit

protocol AdvertBannerViewProtocol: class {
    func advertBanner(_ bannerView: AdvertBannerView, didSelected advert: AdvertModel, at index: Int) -> Void
}

class AdvertBannerView: UIView {

    // MARK: - Internal Property

    var models: [AdvertModel] = [] {
        didSet {
            self.setupModels(models)
        }
    }

    var itemSize: CGSize = CGSize.zero
    var itemHeight: CGFloat = 100 {
        didSet {
            // 需对其设置高度
            self.pagedView.bounds = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.itemHeight)
        }
    }

    /// 回调
    weak var delegate: AdvertBannerViewProtocol?
    var advertSelectedAction: ((_ bannerView: AdvertBannerView, _ advert: AdvertModel, _ index: Int) -> Void)?

    // MARK: - Private Property

    let mainView: UIView = UIView()
    let pagedView: HQFlowView = HQFlowView()

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension AdvertBannerView {
    class func loadXib() -> AdvertBannerView? {
        return Bundle.main.loadNibNamed("AdvertBannerView", owner: nil, options: nil)?.first as? AdvertBannerView
    }
}

// MARK: - LifeCircle Function
extension AdvertBannerView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension AdvertBannerView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.addSubview(self.pagedView)
        self.pagedView.dataSource = self
        self.pagedView.delegate = self
        self.pagedView.isOpenAutoScroll = true
        self.pagedView.autoTime = 3.0
        self.pagedView.minimumPageAlpha = 0.3
        self.pagedView.leftRightMargin = 26     // 24，增大左右间距，解决左侧部分情况下显示一条线的问题，光下面的1间距并不完全可行；
        self.pagedView.snp.makeConstraints { (make) in
            //make.edges.equalToSuperview()
            // edges约束总会让左侧看到一点左侧的图片，故左右减少1的间距
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(1)
            make.trailing.equalToSuperview().offset(-1)
        }

        // pageControl
        let pageControl = UIPageControl()
        self.pagedView.addSubview(pageControl)
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(10)
            make.centerX.equalToSuperview()
        }
        self.pagedView.pageControl = pageControl
    }

}
// MARK: - Private UI Xib加载后处理
extension AdvertBannerView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension AdvertBannerView {
    fileprivate func setupModels(_ models: [AdvertModel]) -> Void {
        self.pagedView.reloadData()
    }
}

// MARK: - Event Function
extension AdvertBannerView {

}

// MARK: - Extension Function
extension AdvertBannerView {

}

// MARK: - Delegate Function

// MARK: - <HQFlowViewDataSource>
extension AdvertBannerView: HQFlowViewDataSource {
    func numberOfPages(in flowView: HQFlowView!) -> Int {
        return self.models.count
    }
    func flowView(_ flowView: HQFlowView!, cellForPageAt index: Int) -> HQIndexBannerSubview! {
        var bannerView = flowView.dequeueReusableCell()
        if bannerView == nil {
            bannerView = HQIndexBannerSubview()
            bannerView?.layer.cornerRadius = 5
            bannerView?.layer.masksToBounds = true
            bannerView?.mainImageView.contentMode = .scaleAspectFill
            bannerView?.coverView.backgroundColor = UIColor.darkGray
        }
        let model = self.models[index]
        bannerView?.mainImageView.kf.setImage(with: model.imageUrl, placeholder: kPlaceHolderImage, options: nil, progressBlock: nil, completionHandler: nil)
        return bannerView
    }
}

// MARK: - <HQFlowViewDelegate>
extension AdvertBannerView: HQFlowViewDelegate {
    func sizeForPage(in flowView: HQFlowView!) -> CGSize {
        let size = CGSize.init(width: kScreenWidth - 24.0, height: self.itemHeight)
        return size
    }
    func didScroll(toPage pageNumber: Int, in flowView: HQFlowView!) {

    }
    func didSelectCell(_ subView: HQIndexBannerSubview!, withSubViewIndex subIndex: Int) {
        //self.delegate?.advertBanner(self, didSelected: models[index], at: index)
        //self.advertSelectedAction?(self, models[index], index)
        let model = models[subIndex]
        NotificationCenter.default.post(name: Notification.Name.AdvertClick, object: model, userInfo: nil)
    }
}
