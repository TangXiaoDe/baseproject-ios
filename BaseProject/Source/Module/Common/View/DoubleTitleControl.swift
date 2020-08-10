//
//  DoubleTitleControl.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  双Title的控件
//  默认横向布局，根据需要自定义布局；
//  注1：该控件应考虑如何在不依赖SnapKit的基础上添加到ChainOneKit库中；

import UIKit

/// 双Title的可点击Control，默认横向加载，使用时需自定义布局
class DoubleTitleControl: UIControl {

    // MARK: - Internal Property

    //static var viewHeight: CGFloat = 44
    /// label1，横向就是左边的，竖向就是上面的
    let firstLabel: UILabel = UILabel()
    /// label2，横向就是右边的，竖向就是下面的
    let secondLabel: UILabel = UILabel()

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
    fileprivate func commonInit() -> Void {
        self.initialUI()
    }
}

// MARK: - Internal Function

// MARK: - Override Function

// MARK: - Private  UI
extension DoubleTitleControl {
    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 1. label1
        self.addSubview(self.firstLabel)
        self.firstLabel.set(text: nil, font: UIFont.systemFont(ofSize: 15), textColor: UIColor.lightGray)
        self.firstLabel.snp.makeConstraints { (make) in
            make.leading.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(0)
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
        }
        // 2. label2
        self.addSubview(self.secondLabel)
        self.secondLabel.set(text: nil, font: UIFont.systemFont(ofSize: 15), textColor: UIColor.lightGray)
        self.secondLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.firstLabel.snp.trailing)
            make.centerY.trailing.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(0)
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
        }
    }
}

// MARK: - Private  数据(处理 与 加载)

// MARK: - Private  事件
