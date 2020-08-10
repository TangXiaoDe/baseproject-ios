//
//  AppNavBar.swift
//  BaseProject
//
//  Created by 小唐 on 2019/7/30.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  自定义导航栏
//  1. 导航栏背景色透明度可调整；
//  2. 标题栏可能隐藏，也可能显示在左侧；

import UIKit

/// 自定义导航栏
class AppNavBar: UIView {
    var leftItem: UIButton?
    var rightItem: UIButton?

    let titleView: UIView = UIView()
    let titleLabel: UILabel = UILabel()

    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    let lrMargin: CGFloat = 12
    let barHeight: CGFloat = 44
    let titleLrMargin: CGFloat = 58   // 居左展示，且左侧只有一个正常leftItem时，

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
        self.addSubview(self.titleView)
        self.titleView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(self.titleLrMargin)
            make.trailing.equalToSuperview().offset(-self.titleLrMargin)
        }
        self.titleView.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.pingFangSCFont(size: 18, weight: .medium), textColor: UIColor.white, alignment: .center)
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
