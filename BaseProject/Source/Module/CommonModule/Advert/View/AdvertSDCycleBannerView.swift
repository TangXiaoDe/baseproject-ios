//
//  AdvertSDCycleBannerView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/21.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  采用SdDCycleScrollView写的轮播图

import UIKit

protocol AdvertSDCycleBannerViewProtocol: class {
    func advertBanner(_ bannerView: AdvertSDCycleBannerView, didSelected advert: AdvertModel, at index: Int) -> Void
}

class AdvertSDCycleBannerView: UIView {

    // MARK: - Internal Property

    var models: [AdvertModel]? {
        didSet {
            self.setupModels(models)
        }
    }

    /// 回调
    weak var delegate: AdvertSDCycleBannerViewProtocol?
    var advertSelectedAction: ((_ bannerView: AdvertSDCycleBannerView, _ advert: AdvertModel, _ index: Int) -> Void)?

    // MARK: - Private Property

    fileprivate let mainView: UIView = UIView()
    fileprivate let cycleView: SDCycleScrollView = SDCycleScrollView()

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
extension AdvertSDCycleBannerView {
    class func loadXib() -> AdvertSDCycleBannerView? {
        return Bundle.main.loadNibNamed("AdvertSDCycleBannerView", owner: nil, options: nil)?.first as? AdvertSDCycleBannerView
    }
}

// MARK: - LifeCircle Function
extension AdvertSDCycleBannerView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension AdvertSDCycleBannerView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.addSubview(self.cycleView)
        cycleView.delegate = self
        cycleView.placeholderImage = kPlaceHolderImage
        cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
        cycleView.autoScrollTimeInterval = 2.5
        cycleView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension AdvertSDCycleBannerView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension AdvertSDCycleBannerView {
    fileprivate func setupModels(_ models: [AdvertModel]?) -> Void {
        self.cycleView.imageURLStringsGroup = []
        guard let models = models else {
            return
        }
        var imageUrls: [String] = []
        for model in models {
            imageUrls.append(model.image)
        }
        self.cycleView.imageURLStringsGroup = imageUrls
    }
}

// MARK: - Event Function
extension AdvertSDCycleBannerView {

}

// MARK: - Extension Function
extension AdvertSDCycleBannerView {

}

// MARK: - Delegate Function
extension AdvertSDCycleBannerView: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        guard let models = self.models else {
            return
        }
        //self.delegate?.advertBanner(self, didSelected: models[index], at: index)
        //self.advertSelectedAction?(self, models[index], index)
        let model = models[index]
        NotificationCenter.default.post(name: Notification.Name.AdvertClick, object: model, userInfo: nil)
    }
}
