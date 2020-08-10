//
//  AppHomeNavStatusView.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  主页导航栏状态栏视图

import UIKit

protocol AppHomeNavStatusViewProtocol: class {
    /// 导航栏左侧按钮点击回调
    func homeBar(_ navBar: AppHomeNavStatusView, didClickedLeftItem itemView: UIButton) -> Void
    /// 导航栏右侧按钮点击回调
    func homeBar(_ navBar: AppHomeNavStatusView, didClickedRightItem itemView: UIButton) -> Void
}
extension AppHomeNavStatusViewProtocol {
    /// 导航栏右侧按钮点击回调
    func homeBar(_ navBar: AppHomeNavStatusView, didClickedRightItem itemView: UIButton) -> Void {}
}

/// 主页导航栏状态栏视图
class AppHomeNavStatusView: UIView {
    static let viewHeight: CGFloat = kNavigationStatusBarHeight

    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    weak var delegate: AppHomeNavStatusViewProtocol?

    let statusBar: UIView = UIView()

    let navBar: UIView = UIView()
    var leftItem: UIButton = UIButton.init(type: .custom)
    var rightItem: UIButton = UIButton.init(type: .custom)
    let titleView: UIView = UIView()
    let titleLabel: UILabel = UILabel()

    let lrMargin: CGFloat = 12
    let statusHeight: CGFloat = kStatusBarHeight
    let navbarHeight: CGFloat = kNavigationBarHeight
    let titleLrMargin: CGFloat = 58   // 居左展示，且左侧只有一个正常leftItem时，
    var itemSize: CGSize = CGSize.init(width: 32, height: 32) {
        didSet {
            self.rightItem.snp.remakeConstraints { (make) in
                make.trailing.equalToSuperview().offset(-12)
                make.centerY.equalToSuperview()
                make.size.equalTo(self.itemSize)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 默认加载控件
    func commonInit() -> Void {
        // statusBar
        self.addSubview(self.statusBar)
        self.statusBar.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.statusHeight)
        }
        // navBar
        self.addSubview(self.navBar)
        self.initialNavBar(self.navBar)
        self.navBar.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(self.navbarHeight)
        }
    }

    fileprivate func initialNavBar(_ barView: UIView) -> Void {
        // titleView
        barView.addSubview(self.titleView)
        self.titleView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(self.titleLrMargin)
            make.trailing.equalToSuperview().offset(-self.titleLrMargin)
        }
        self.titleView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 18, weight: .medium), textColor: UIColor.white, alignment: .center)  // default align center
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // leftItem
        barView.addSubview(self.leftItem)
        self.leftItem.setImage(UIImage.init(named: "IMG_icon_profile_back"), for: .normal)
        self.leftItem.addTarget(self, action: #selector(leftItemClick(_:)), for: .touchUpInside)
        self.leftItem.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(self.itemSize)
        }

        // rightItem
        barView.addSubview(self.rightItem)
        self.rightItem.setImage(UIImage.init(named: "IMG_icon_profile_more"), for: .normal)
        self.rightItem.addTarget(self, action: #selector(rightItemClick(_:)), for: .touchUpInside)
        self.rightItem.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(self.itemSize)
        }
    }

    @objc fileprivate func leftItemClick(_ button: UIButton) -> Void {
        self.delegate?.homeBar(self, didClickedLeftItem: button)
    }
    @objc fileprivate func rightItemClick(_ button: UIButton) -> Void {
        self.delegate?.homeBar(self, didClickedRightItem: button)
    }

}
