//
//  AdvertBannerItemView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/13.
//  Copyright © 2019 ChainOne. All rights reserved.
//

import UIKit

protocol AdvertBannerItemViewProtocol: class {
    /// itemView点击响应回调
    func itemView(_ itemView: AdvertBannerItemView, didClicked itemModel: AdvertModel) -> Void
}

class AdvertBannerItemView: UIControl {

    // MARK: - Internal Property

    weak var delegate: AdvertBannerItemViewProtocol?
    var itemClickAction: ((_ itemView: AdvertBannerItemView, _ itemModel: AdvertModel) -> Void)?

    let actionControl: UIControl = UIControl()
    let imageView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()

    var model: AdvertModel? {
        didSet {
            self.setupModel(model)
        }
    }

    // MARK: - Private Property

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
extension AdvertBannerItemView {
    class func loadXib() -> AdvertBannerItemView? {
        return Bundle.main.loadNibNamed("AdvertBannerItemView", owner: nil, options: nil)?.first as? AdvertBannerItemView
    }
}

// MARK: - LifeCircle Function
extension AdvertBannerItemView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension AdvertBannerItemView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 1. imageView
        self.addSubview(self.imageView)
        self.imageView.set(cornerRadius: 0)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // 2. titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.systemFont(ofSize: 10), textColor: UIColor(hex: 0x66666))
        self.titleLabel.isHidden = true // 默认隐藏
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-45)
        }
        // 0. actionControl
        self.addSubview(self.actionControl)
        self.actionControl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension AdvertBannerItemView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension AdvertBannerItemView {
    /// 数据模型加载
    fileprivate func setupModel(_ model: AdvertModel?) -> Void {
//        guard let model = model else {
//            self.imageView.image = nil
//            return
//        }
//        self.imageView.kf.setImage(with: URL(string: model.image), placeholder: kPlaceHolderImage, options: nil, progressBlock: nil, completionHandler: nil)

        self.imageView.backgroundColor = UIColor.red

    }
}

// MARK: - Event Function
extension AdvertBannerItemView {
    @objc fileprivate func actionControlClick(_ control: UIControl) -> Void {
        guard let model = self.model else {
            return
        }
        self.delegate?.itemView(self, didClicked: model)
        self.itemClickAction?(self, model)
        // 发送通知

    }
}

// MARK: - Extension Function
extension AdvertBannerItemView {

}
