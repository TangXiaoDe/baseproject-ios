//
//  SettingItemCell.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/24.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  设置Item的Cell

import UIKit

protocol SettingItemCellProtocol: class {
    func settingCell(_ cell: SettingItemCell, didSwitchValueChanged switchView: CommonSwitchView) -> Void
}
extension SettingItemCellProtocol {
    func settingCell(_ cell: SettingItemCell, didSwitchValueChanged switchView: CommonSwitchView) -> Void {}
}

/// 设置Item的Cell
class SettingItemCell: UITableViewCell {

    // MARK: - Internal Property
    static let cellHeight: CGFloat = 56
    /// 重用标识符
    static let identifier: String = "SettingItemCellReuseIdentifier"

    /// 回调处理
    weak var delegate: SettingItemCellProtocol?
    var switchValueChangedAction: ((_ cell: SettingItemCell, _ switchView: CommonSwitchView) -> Void)?


    var model: SettingItemModel? {
        didSet {
            self.setupWithModel(model)
        }
    }
    var showBottomLine: Bool = true {
        didSet {
            self.bottomLine.isHidden = !showBottomLine
        }
    }
    var indexPath: IndexPath?

    let mainView = UIView()
    let leftIconView: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let detailLabel: UILabel = UILabel()
    let rightIconView: UIImageView = UIImageView()
    //let switchView: UISwitch = UISwitch()
    let switchView: CommonSwitchView = CommonSwitchView()
    weak fileprivate(set) var bottomLine: UIView!


    // MARK: - fileprivate Property

    /// 外界可传入更新，在传入model之前，否则无效
    var detailLeftMargin: CGFloat = 84       // superView

    fileprivate let lrMargin: CGFloat = 12
    fileprivate let titleIconLeftMargin: CGFloat = 26   // 当leftIcon存在时titleLabel距离左侧的间距
    fileprivate let detailIconRightMargin: CGFloat = 26 // 当rightIcon存在时detailLabel距离右侧的间距
    fileprivate let lineLrMargin: CGFloat = 0
    fileprivate let switchSize: CGSize = CGSize.init(width: CommonSwitchView.viewWidth, height: CommonSwitchView.viewHeight)

    // MARK: - Initialize Function

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
    }

}

// MARK: - Internal Function
extension SettingItemCell {
    /// 便利构造方法
    class func cellInTableView(_ tableView: UITableView, at indexPath: IndexPath? = nil) -> SettingItemCell {
        let identifier = SettingItemCell.identifier
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if nil == cell {
            cell = SettingItemCell.init(style: .default, reuseIdentifier: identifier)
        }
        // 状态重置
        if let cell = cell as? SettingItemCell {
            cell.resetSelf()
            cell.indexPath = indexPath
        }
        return cell as! SettingItemCell
    }

    /// 重新加载右侧icon：大小 和 居左还是居右
    func reloadRightIcon(size: CGSize, isRight: Bool) -> Void {
        // 默认布局
        self.rightIconView.contentMode = .scaleAspectFit
        self.rightIconView.snp.remakeConstraints { (make) in
            make.size.equalTo(size)
            make.centerY.equalToSuperview()
            if isRight {
                make.trailing.equalToSuperview().offset(-self.lrMargin)
            } else {
                make.leading.equalToSuperview().offset(self.detailLeftMargin)
            }
        }
        self.mainView.layoutIfNeeded()
    }

}

// MARK: - Override Function
extension SettingItemCell {
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
extension SettingItemCell {
    // 界面布局
    fileprivate func initialUI() -> Void {
        // mainView - 整体布局，便于扩展，特别是针对分割、背景色、四周间距
        self.contentView.addSubview(mainView)
        self.initialMainView(self.mainView)
        mainView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // bottomLine
        self.bottomLine = mainView.addLineWithSide(.inBottom, color: AppColor.pageBg, thickness: 0.5, margin1: self.lineLrMargin, margin2: self.lineLrMargin)
    }
    // 主视图布局
    fileprivate func initialMainView(_ mainView: UIView) -> Void {
        mainView.backgroundColor = UIColor.init(hex: 0x2D385C)
        // 1. leftIcon
        mainView.addSubview(self.leftIconView)
        self.leftIconView.contentMode = .left
        self.leftIconView.isHidden = true       // 默认隐藏
        self.leftIconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.lrMargin)
        }
        // 2. rightIcon
        mainView.addSubview(self.rightIconView)
        self.rightIconView.contentMode = .right
        self.rightIconView.isHidden = true       // 默认隐藏
        self.rightIconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-self.lrMargin)
        }
        // 3. titleLabel
        mainView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.white)
        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.lrMargin)
        }
        // 4. detailLabel
        mainView.addSubview(self.detailLabel)
        self.detailLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.init(hex: 0x8C97AC), alignment: .right)
        self.detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.detailLeftMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
        }
        // 5. switchView - 可根据需要进行优化或自定义
        mainView.addSubview(self.switchView)
        self.switchView.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        self.switchView.isHidden = true // 默认隐藏
        self.switchView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-self.lrMargin)
            make.size.equalTo(self.switchSize)
        }

    }
}

// MARK: - Data 数据加载
extension SettingItemCell {
    /// 重置
    fileprivate func resetSelf() -> Void {
        self.selectionStyle = .none

        // 默认样式: leftTitle

        self.leftIconView.image = nil
        self.bottomLine.isHidden = false

        self.rightIconView.image = nil
        self.rightIconView.contentMode = .right
        self.rightIconView.isHidden = true       // 默认隐藏
        self.rightIconView.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-self.lrMargin)
        }

        self.titleLabel.isHidden = false
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 16), textColor: UIColor.white)
        self.titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.lrMargin)
        }

        self.detailLabel.isHidden = true
        self.detailLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 12), textColor: UIColor.init(hex: 0x8C97AC), alignment: .right)
        self.detailLabel.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(self.detailLeftMargin)
            make.trailing.equalToSuperview().offset(-self.lrMargin)
        }

        self.switchView.isHidden = true
        self.detailLeftMargin = 84  // 恢复默认值
        self.mainView.layoutIfNeeded()
    }
    /// 数据加载
    fileprivate func setupWithModel(_ model: SettingItemModel?) -> Void {
        guard let model = model else {
            return
        }
        self.titleLabel.text = model.title
        self.detailLabel.text = model.detail
        self.switchView.isOn = model.isSwitchOn

        switch model.type {
        case .custom:
            break
        case .leftTitle:
            break
        case .centerTitle:
            self.titleLabel.textColor = UIColor.init(hex: 0xEA445C)
            self.titleLabel.textAlignment = .center
            self.titleLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(self.lrMargin)
                make.trailing.equalToSuperview().offset(-self.lrMargin)
            }
        case .rightTitle:
            self.titleLabel.textAlignment = .right
            self.titleLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(self.lrMargin)
                make.trailing.equalToSuperview().offset(-self.lrMargin)
            }
        case .rightSwitch:
            self.switchView.isHidden = false
        case .rightAccessory:
            self.rightIconView.isHidden = false
            self.rightIconView.image = model.accessory
        case .rightIcon:
            self.rightIconView.isHidden = false
            self.rightIconView.image = model.rightIcon
            self.rightIconView.contentMode = .right
        case .rightIconLeft:
            self.rightIconView.isHidden = false
            self.rightIconView.image = model.rightIcon
            self.rightIconView.contentMode = .left
            self.rightIconView.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(self.detailLeftMargin)
            }
        case .rightDetail:
            self.detailLabel.isHidden = false
        case .rightDetailLeft:
            self.detailLabel.isHidden = false
            self.detailLabel.textAlignment = .left
            self.detailLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(self.detailLeftMargin)
                make.trailing.equalToSuperview().offset(-self.detailIconRightMargin)
            }
        case .rightDetailAccessory:
            self.detailLabel.isHidden = false
            self.rightIconView.isHidden = false
            self.rightIconView.image = model.accessory
            self.detailLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(self.detailLeftMargin)
                make.trailing.equalToSuperview().offset(-self.detailIconRightMargin)
            }
        case .rightDetailLeftAccessory:
            self.detailLabel.isHidden = false
            self.detailLabel.textAlignment = .left
            self.rightIconView.isHidden = false
            self.rightIconView.image = model.accessory
            self.detailLabel.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().offset(self.detailLeftMargin)
                make.trailing.equalToSuperview().offset(-self.detailIconRightMargin)
            }
        }
        self.mainView.layoutIfNeeded()
    }

}

// MARK: - Event  事件响应
extension SettingItemCell {
    /// switch控件值更改响应
    @objc fileprivate func switchValueChanged(_ switchView: CommonSwitchView) -> Void {
        self.delegate?.settingCell(self, didSwitchValueChanged: switchView)
        self.switchValueChangedAction?(self, switchView)
    }

}
