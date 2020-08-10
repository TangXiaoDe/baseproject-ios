//
//  ListEmptyPlaceHolderView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/2/18.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  列表为空时的的默认图
//  关于 是否统一默认图的问题，根据之后的情况来处理

import UIKit

typealias ListEmptyDefaultView = ListEmptyPlaceHolderView
typealias ListPlaceHolderView = ListEmptyPlaceHolderView
class ListEmptyPlaceHolderView: UIView {

    // MARK: - Internal Property

    let mainView: UIView = UIView()
    let iconView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()

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
        self.initialUI()
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension ListEmptyPlaceHolderView {
    class func loadXib() -> ListEmptyPlaceHolderView? {
        return Bundle.main.loadNibNamed("ListEmptyPlaceHolderView", owner: nil, options: nil)?.first as? ListEmptyPlaceHolderView
    }
}

// MARK: - LifeCircle Function
extension ListEmptyPlaceHolderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension ListEmptyPlaceHolderView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.addSubview(self.mainView)
        self.initialMainView(self.mainView)
        self.mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        // 1. iconView
        mainView.addSubview(self.iconView)
        self.set(cornerRadius: 0)
        self.iconView.image = UIImage.init(named: "IMG_bg_placeholder_empty_data")
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mainView.snp.centerY).offset(0)
        }
        // 2. titleLabel
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: "暂无内容~", font: UIFont.systemFont(ofSize: 15), textColor: UIColor(hex: 0x8C97AC), alignment: .center)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension ListEmptyPlaceHolderView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension ListEmptyPlaceHolderView {

}

// MARK: - Event Function
extension ListEmptyPlaceHolderView {

}

// MARK: - Extension Function
extension ListEmptyPlaceHolderView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension ListEmptyPlaceHolderView {

}
