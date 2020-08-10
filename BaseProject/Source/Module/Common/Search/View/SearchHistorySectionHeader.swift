//
//  SearchHistorySectionHeader.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  搜索历史记录表头

import Foundation

protocol SearchHistorySectionHeaderProtocol: class {
    /// 清理控件点击回调
    func header(_ header: SearchHistorySectionHeader, didClickedClear clearControl: UIControl) -> Void
}

/// 搜索历史记录表头
class SearchHistorySectionHeader: UITableViewHeaderFooterView {

    // MARK: - Internal Property
    static let headerHeight: CGFloat = 45
    static let identifier: String = "SearchHistorySectionHeaderReuseIdentifier"

    /// 回调
    weak var delegate: SearchHistorySectionHeaderProtocol?
    var clearAction:((_ header: SearchHistorySectionHeader, _ clearControl: UIControl) -> Void)?

    // MARK: - Private Property

    fileprivate let iconView: UIImageView = UIImageView()
    fileprivate let titleLabel: UILabel = UILabel()
    fileprivate let clearControl: IconTitleControl = IconTitleControl()

    fileprivate let lrMargin: CGFloat = 12
    fileprivate let iconWH: CGFloat = 16
    fileprivate let titleLeftMargin: CGFloat = 5
    fileprivate let iconCenterYBottomMargin: CGFloat = 16


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
extension SearchHistorySectionHeader {
    /// 便利构造
    class func headerInTableView(_ tableView: UITableView) -> SearchHistorySectionHeader {
        let identifier = self.identifier
        var headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if nil == headerFooterView {
            headerFooterView = SearchHistorySectionHeader.init(reuseIdentifier: identifier)
        }
        // 状态重置
        if let headerFooterView = headerFooterView as? SearchHistorySectionHeader {
            headerFooterView.resetSelf()
        }
        return headerFooterView as! SearchHistorySectionHeader
    }

}

// MARK: - Override/LifeCycle Function
extension SearchHistorySectionHeader {

}

// MARK: - UI
extension SearchHistorySectionHeader {
    /// 重置
    fileprivate func resetSelf() -> Void {

    }

    /// 界面布局
    fileprivate func initialUI() -> Void {
        self.contentView.backgroundColor = AppColor.pageBg
        // 1. iconView
        self.contentView.addSubview(self.iconView)
        self.iconView.image = UIImage.init(named: "IMG_search_history")
        self.iconView.set(cornerRadius: 0)
        self.iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.iconWH)
            make.centerY.equalTo(self.contentView.snp.bottom).offset(-self.iconCenterYBottomMargin)
            make.leading.equalToSuperview().offset(self.lrMargin)
        }
        // 2. titleLabel
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.set(text: "搜索历史", font: UIFont.pingFangSCFont(size: 14), textColor: UIColor.init(hex: 0x8C97AC))
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.iconView)
            make.leading.equalTo(self.iconView.snp.trailing).offset(self.titleLeftMargin)
        }
        // 3. iconTitleControl
        self.contentView.addSubview(self.clearControl)
        self.clearControl.addTarget(self, action: #selector(clearControlClick(_:)), for: .touchUpInside)
        self.clearControl.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.iconView)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
        }
        self.clearControl.iconView.image = UIImage.init(named: "IMG_search_history_delete")
        self.clearControl.iconView.snp.remakeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(5)
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
        self.clearControl.titleLabel.set(text: "清空", font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.init(hex: 0x8C97AC))
        self.clearControl.titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.clearControl.iconView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(5)
            make.bottom.lessThanOrEqualToSuperview().offset(-5)
        }

    }

}

// MARK: - Data
extension SearchHistorySectionHeader {

}

// MARK: - Event
extension SearchHistorySectionHeader {
    /// 清理控件点击响应
    @objc fileprivate func clearControlClick(_ control: UIControl) -> Void {
        self.delegate?.header(self, didClickedClear: control)
        self.clearAction?(self, control)
    }

}

// MARK: - Notification

// MARK: - Delegate
