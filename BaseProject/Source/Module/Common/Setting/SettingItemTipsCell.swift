//
//  SettingItemTipsCell.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/1.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  设置选项的提示Cell

import UIKit

/// 设置选项的提示Cell
class SettingItemTipsCell: UITableViewCell {

    // MARK: - Internal Property
    static let cellHeight: CGFloat = 40     // 单行高度
    /// 重用标识符
    static let identifier: String = "SettingItemTipsCellReuseIdentifier"

    var model: String? {
        didSet {
            self.setupWithModel(model)
        }
    }

    // MARK: - fileprivate Property

    let mainView: UIView = UIView()
    let tipsLabel: UILabel = UILabel()

    fileprivate let lrMargin: CGFloat = 12
    fileprivate let tbMargin: CGFloat = 13

    // MARK: - Initialize Function

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
extension SettingItemTipsCell {
    /// 便利构造方法
    class func cellInTableView(_ tableView: UITableView) -> SettingItemTipsCell {
        let identifier = SettingItemTipsCell.identifier
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if nil == cell {
            cell = SettingItemTipsCell.init(style: .default, reuseIdentifier: identifier)
        }
        // 状态重置
        if let cell = cell as? SettingItemTipsCell {
            cell.resetSelf()
        }
        return cell as! SettingItemTipsCell
    }
}

// MARK: - Override Function
extension SettingItemTipsCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - UI 界面布局
extension SettingItemTipsCell {
    // 界面布局
    fileprivate func initialUI() -> Void {
        // mainView - 整体布局，便于扩展，特别是针对分割、背景色、四周间距
        self.contentView.addSubview(mainView)
        self.initialMainView(self.mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    // 主视图布局
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.backgroundColor = AppColor.pageBg
        // tipsLabel
        mainView.addSubview(self.tipsLabel)
        self.tipsLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12, weight: .medium), textColor: UIColor.init(hex: 0x9AA1AD))
        self.tipsLabel.numberOfLines = 0
        self.tipsLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.lrMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(self.tbMargin)
            make.bottom.lessThanOrEqualToSuperview().offset(-self.tbMargin)
        }
    }
}

// MARK: - Data 数据加载
extension SettingItemTipsCell {
    /// 重置
    fileprivate func resetSelf() -> Void {
        self.selectionStyle = .none
    }
    /// 数据加载
    fileprivate func setupWithModel(_ model: String?) -> Void {
        guard let model = model else {
            return
        }
        self.tipsLabel.text = model
    }
}

// MARK: - Event  事件响应
extension SettingItemTipsCell {

}
