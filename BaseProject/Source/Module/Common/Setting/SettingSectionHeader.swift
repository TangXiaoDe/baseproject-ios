//
//  SettingSectionHeader.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  设置页中的SectionHeader

import UIKit

/// 设置页中的SectionHeader
class SettingSectionHeader: UITableViewHeaderFooterView {

    // MARK: - Internal Property
    static let headerHeight: CGFloat = 33
    static let separateHeight: CGFloat = 12
    static let identifier: String = "SettingSectionHeaderReuseIdentifier"

    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    // MARK: - Private Property

    // 左侧 标题
    let titleLabel: UILabel = UILabel()
    // 右侧 附加信息
    let accessoryLabel: UILabel = UILabel()

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
extension SettingSectionHeader {
    /// 便利构造
    class func headerInTableView(_ tableView: UITableView) -> SettingSectionHeader {
        let identifier = SettingSectionHeader.identifier
        var headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if nil == headerFooterView {
            headerFooterView = SettingSectionHeader.init(reuseIdentifier: identifier)
        }
        // 状态重置
        if let headerFooterView = headerFooterView as? SettingSectionHeader {
            headerFooterView.resetSelf()
        }
        return headerFooterView as! SettingSectionHeader
    }

}

// MARK: - Override/LifeCycle Function
extension SettingSectionHeader {

}

// MARK: - UI
extension SettingSectionHeader {
    /// 重置
    fileprivate func resetSelf() -> Void {
        self.titleLabel.text = nil
    }

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.contentView.backgroundColor = AppColor.pageBg
        // titleLabel
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.init(hex: 0x8C97AC))
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.lessThanOrEqualToSuperview().offset(-self.lrMargin)
        }
        // accessoryLabel
        self.contentView.addSubview(self.accessoryLabel)
        self.accessoryLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.init(hex: 0x8C97AC), alignment: .right)
        self.accessoryLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-self.lrMargin)
            make.leading.greaterThanOrEqualToSuperview().offset(self.lrMargin)
        }
    }

}

// MARK: - Data
extension SettingSectionHeader {

}

// MARK: - Event
extension SettingSectionHeader {

}

// MARK: - Notification

// MARK: - Delegate
