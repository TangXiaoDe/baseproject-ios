//
//  SearchHistoryCell.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/19.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  搜索历史记录Cell

import UIKit

/// 搜索历史记录Cell
class SearchHistoryCell: UITableViewCell {

    // MARK: - Internal Property
    static let cellHeight: CGFloat = 75
    /// 重用标识符
    static let identifier: String = "SearchHistoryCellReuseIdentifier"

    var model: SearchHistoryModel? {
        didSet {
            self.setupWithModel(model)
        }
    }

    // MARK: - fileprivate Property

    fileprivate let mainView: UIView = UIView()
    fileprivate let titleLabel: UILabel = UILabel()

    fileprivate let leftMargin: CGFloat = 32
    fileprivate let rightMragin: CGFloat = 12
    fileprivate let tbMargin: CGFloat = 10


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
extension SearchHistoryCell {
    /// 便利构造方法
    class func cellInTableView(_ tableView: UITableView) -> SearchHistoryCell {
        let identifier = SearchHistoryCell.identifier
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if nil == cell {
            cell = SearchHistoryCell.init(style: .default, reuseIdentifier: identifier)
        }
        // 状态重置
        if let cell = cell as? SearchHistoryCell {
            cell.resetSelf()
        }
        return cell as! SearchHistoryCell
    }
}

// MARK: - Override Function
extension SearchHistoryCell {
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
extension SearchHistoryCell {
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
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.init(hex: 0x8C97AC))
        self.titleLabel.numberOfLines = 2
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.leftMargin)
            make.trailing.equalToSuperview().offset(-self.rightMragin)
            make.top.equalToSuperview().offset(self.tbMargin)
            make.bottom.equalToSuperview().offset(-self.tbMargin)
        }
    }
}

// MARK: - Data 数据加载
extension SearchHistoryCell {
    /// 重置
    fileprivate func resetSelf() -> Void {
        self.selectionStyle = .none
    }
    /// 数据加载
    fileprivate func setupWithModel(_ model: SearchHistoryModel?) -> Void {
        guard let model = model else {
            return
        }
        self.titleLabel.text = model.title
    }

}

// MARK: - Event  事件响应
extension SearchHistoryCell {

}
