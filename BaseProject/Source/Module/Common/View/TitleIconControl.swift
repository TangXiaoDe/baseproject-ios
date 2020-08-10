//
//  TitleIconControl.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  标题图标Control
//  需要自己重新布局和设置
//  注1：该控件应考虑如何在不依赖SnapKit的基础上添加到ChainOneKit库中；

import UIKit

/// 图标标题控件
typealias IconTitleControl = TitleIconControl
/// 标题图标Control 需自己重新布局和设置
class TitleIconControl: UIControl {

    // MARK: - Internal Property

    //static var viewHeight: CGFloat = 44
    let titleLabel: UILabel = UILabel()
    let iconView: UIImageView = UIImageView()
    let tagImgView: UIImageView = UIImageView()

    // MARK: - Private Property

    // MARK: - Initialize Function

    init() {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    /// 通用初始化
    func commonInit() -> Void {
        self.initialUI()
    }
}

// MARK: - Internal Function
extension TitleIconControl {
    // 该方案待完成
//    func setTitle(_ title: String?, icon: UIImage?, titleColor: UIColor, bgColor: UIColor, for state: UIControl.State) -> Void {
//
//    }

}

// MARK: - Override Function

// MARK: - Private  UI
extension TitleIconControl {
    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 1. titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.systemFont(ofSize: 15), textColor: UIColor.lightGray)
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
        }
        // 2. iconView
        self.addSubview(self.iconView)
        self.iconView.set(cornerRadius: 0)
        self.iconView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.titleLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        // 2. tagView
        self.addSubview(self.tagImgView)
        self.tagImgView.isHidden = true
        self.tagImgView.image = UIImage.init(named: "IMG_icon_official_max")
        self.tagImgView.snp.makeConstraints { (make) in
            make.right.equalTo(self.iconView.snp.right)
            make.bottom.equalTo(self.iconView.snp.bottom)
            make.size.equalTo(CGSize.init(width: 18, height: 18))
        }
    }
}

// MARK: - Private  数据(处理 与 加载)

// MARK: - Private  事件
