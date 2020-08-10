//
//  AdvertIcarouselBannerView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/14.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

class AdvertIcarouselBannerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//import UIKit
//
//class AdvertBannerView: UIView {
//
//    // MARK: - Internal Property
//
//    var models: [AdvertModel] = [] {
//        didSet {
//            self.carousel.reloadData()
//        }
//    }
//
//    var itemSize: CGSize = CGSize(width: kScreenWidth, height: 100)
//
//    // MARK: - Private Property
//
//    fileprivate let mainView: UIView = UIView()
//
//    fileprivate let carousel: iCarousel = iCarousel()
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
//        //fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//// MARK: - Internal Function
//extension AdvertBannerView {
//    class func loadXib() -> AdvertBannerView? {
//        return Bundle.main.loadNibNamed("AdvertBannerView", owner: nil, options: nil)?.first as? AdvertBannerView
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
//        mainView.addSubview(self.carousel)
//        self.carousel.dataSource = self
//        self.carousel.delegate = self
//        self.carousel.type = iCarouselType.linear
//        self.carousel.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
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
//
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
//// MARK: - Delegate Function
//
//// MARK: - <iCarouselDataSource>
//extension AdvertBannerView: iCarouselDataSource {
//    func numberOfItems(in carousel: iCarousel) -> Int {
//        return self.models.count
//    }
//
//    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
////        var itemView: AdvertBannerItemView
////
////        if let view = view as? AdvertBannerItemView {
////            itemView = view
////        } else {
////            itemView = AdvertBannerItemView()
////        }
////        itemView.model = self.models[index]
////        return itemView
//
//        var itemView: UILabel
//
//        if let view = view as? UILabel {
//            itemView = view
//        } else {
//            itemView = UILabel()
//        }
//
//        itemView.text = "哈哈哈"
//        itemView.textAlignment = .center
//
//
//        return itemView
//    }
//
//}
//
//// MARK: - <iCarouselDataSource>
//extension AdvertBannerView: iCarouselDelegate {
//    func carouselItemWidth(_ carousel: iCarousel) -> CGFloat {
//        return self.itemSize.width
//    }
//}
