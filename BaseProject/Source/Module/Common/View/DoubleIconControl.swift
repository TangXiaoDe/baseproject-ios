//
//  DoubleIconControl.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  双icon的控件
//  默认横向布局，根据需要进行自定义布局；
//  注1：该控件应考虑如何在不依赖SnapKit的基础上添加到ChainOneKit库中；

import UIKit

/// 双icon的可点击Control，默认横向加载，使用时需自定义布局
class DoubleIconControl: UIControl {

    // MARK: - Internal Property

    //static var viewHeight: CGFloat = 44
    /// icon1，横向就是左边的，竖向就是上面的
    let firstIconView: UIImageView = UIImageView()
    /// icon2，横向就是右边的，竖向就是下面的
    let secondIconView: UIImageView = UIImageView()

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
        self.reLayout()
    }
}

// MARK: - Internal Function

extension DoubleIconControl {
    /// 重新布局，用于子类重写；若重写，则需移除内部控件的约束
    func reLayout() -> Void {

    }
}

// MARK: - Override Function

// MARK: - Private  UI
extension DoubleIconControl {
    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 1. icon1
        self.addSubview(self.firstIconView)
        self.firstIconView.set(cornerRadius: 0)
        self.firstIconView.snp.makeConstraints { (make) in
            make.leading.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(0)
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
        }
        // 2. icon2
        self.addSubview(self.secondIconView)
        self.secondIconView.set(cornerRadius: 0)
        self.secondIconView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.firstIconView.snp.trailing)
            make.centerY.trailing.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(0)
            make.bottom.lessThanOrEqualToSuperview().offset(-0)
        }
    }
}

// MARK: - Private  数据(处理 与 加载)

// MARK: - Private  事件
