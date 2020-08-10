//
//  SettingSectionFooter.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/25.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  设置页中的SectionFooter

import Foundation

/// 设置页中的SectionFooter
class SettingSectionFooter: UITableViewHeaderFooterView {

    // MARK: - Internal Property
    static let headerHeight: CGFloat = 12
    static let identifier: String = "SettingSectionFooterReuseIdentifier"

    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    // MARK: - Private Property

    let titleLabel: UILabel = UILabel()

    fileprivate let lrMargin: CGFloat = 12

    // MARK: - Initialize Function

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    /// 通用初始化：UI、配置、数据等
    fileprivate func commonInit() -> Void {
        self.initialUI()
    }

}

// MARK: - Internal Function
extension SettingSectionFooter {
    /// 便利构造
    class func footerInTableView(_ tableView: UITableView) -> SettingSectionFooter {
        let identifier = self.identifier
        var headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if nil == headerFooterView {
            headerFooterView = SettingSectionFooter.init(reuseIdentifier: identifier)
        }
        // 状态重置
        if let headerFooterView = headerFooterView as? SettingSectionFooter {
            headerFooterView.resetSelf()
        }
        return headerFooterView as! SettingSectionFooter
    }

}

// MARK: - Override/LifeCycle Function
extension SettingSectionFooter {

}

// MARK: - UI
extension SettingSectionFooter {
    /// 重置
    fileprivate func resetSelf() -> Void {
        self.titleLabel.text = nil
    }

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.contentView.backgroundColor = AppColor.pageBg
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12, weight: .medium), textColor: UIColor.init(hex: 0x8C97AC))
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
        }
    }

}

// MARK: - Data
extension SettingSectionFooter {

}

// MARK: - Event
extension SettingSectionFooter {

}

// MARK: - Notification

// MARK: - Delegate
