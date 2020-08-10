//
//  Toast.swift
//  BaseProject
//
//  Created by 小唐 on 2019/4/9.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  Toast 弹窗

import UIKit

class ToastView: UIView {

    // MARK: - Internal Property

    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }

    let titleLabel: UILabel = UILabel()
    static let viewHeight: CGFloat = 40

    // MARK: - Private Property

    fileprivate let lrMargin: CGFloat = 30
    fileprivate let tbMargin: CGFloat = 13

    // MARK: - Initialize Function
    init() {
        super.init(frame: CGRect.zero)
        self.initialUI()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialUI()
        //fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal Function
extension ToastView {

}

// MARK: - LifeCircle Function
extension ToastView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
// MARK: - Private UI 手动布局
extension ToastView {

    /// 界面布局
    fileprivate func initialUI() -> Void {
        // 1. self
        self.backgroundColor = UIColor.init(hex: 0x333333).withAlphaComponent(0.8)
        self.set(cornerRadius: 5)
        // 2. titleLabel
        self.addSubview(self.titleLabel)
        self.titleLabel.set(text: nil, font: UIFont.systemFont(ofSize: 14), textColor: UIColor.white, alignment: .center)
        self.titleLabel.numberOfLines = 3
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(lrMargin)
            make.trailing.equalToSuperview().offset(-lrMargin)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(tbMargin)
            make.bottom.equalToSuperview().offset(-tbMargin)
            make.height.greaterThanOrEqualTo(14)
        }
    }

}
// MARK: - Private UI Xib加载后处理
extension ToastView {

}

// MARK: - Data Function
extension ToastView {

}

// MARK: - Event Function
extension ToastView {

}

// MARK: - Extension Function
extension ToastView {

}

// MARK: - Delegate Function

// MARK: - <XXXDelegate>
extension ToastView {

}
