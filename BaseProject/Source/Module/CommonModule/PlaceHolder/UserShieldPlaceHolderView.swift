//
//  UserShieldPlaceHolderView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/9/3.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  用户屏蔽占位图

import UIKit

/// 用户屏蔽占位图
class UserShieldPlaceHolderView: UIView {

    // MARK: - Internal Property

    let mainView: UIView = UIView()
    let iconView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()

    // MARK: - Private Property

    fileprivate let iconTopMargin: CGFloat = 107
    fileprivate let iconSize: CGSize = CGSize.init(width: 40, height: 32)


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
extension UserShieldPlaceHolderView {
    class func loadXib() -> UserShieldPlaceHolderView? {
        return Bundle.main.loadNibNamed("UserShieldPlaceHolderView", owner: nil, options: nil)?.first as? UserShieldPlaceHolderView
    }
}

// MARK: - LifeCircle Function
extension UserShieldPlaceHolderView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialInAwakeNib()
    }
}
// MARK: - Private UI 手动布局
extension UserShieldPlaceHolderView {

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
        self.iconView.image = UIImage.init(named: "IMG_icon_user_shield_lookhim")
        self.iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(self.iconSize)
            make.top.equalToSuperview().offset(self.iconTopMargin)
        }
        // 2. titleLabel
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: "您已屏蔽对方动态\n如需查看请到“好友动态设置”或“隐私设置”里取消屏蔽", font: UIFont.pingFangSCFont(size: 12), textColor: UIColor(hex: 0x8C97AC), alignment: .center)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.iconView.snp.bottom).offset(12)
            make.leading.greaterThanOrEqualToSuperview().offset(0)
            make.trailing.lessThanOrEqualToSuperview().offset(-0)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension UserShieldPlaceHolderView {
    /// awakeNib时的处理
    fileprivate func initialInAwakeNib() -> Void {

    }
}

// MARK: - Data Function
extension UserShieldPlaceHolderView {

}

// MARK: - Event Function
extension UserShieldPlaceHolderView {

}

// MARK: - Extension Function
extension UserShieldPlaceHolderView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension UserShieldPlaceHolderView {

}
