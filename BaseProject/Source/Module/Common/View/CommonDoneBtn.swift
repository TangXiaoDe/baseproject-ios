//
//  CommonDoneBtn.swift
//  BaseProject
//
//  Created by 小唐 on 2019/5/29.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  CommonDoneButton 通用的确定按钮
//  normal下的显示渐变背景色

import UIKit

/// 通用的确定按钮
typealias AppDoneBtn = CommonDoneBtn
/// 通用的确定按钮，注：需对gradientLayer指定大小
class CommonDoneBtn: BaseButton {

    /// 需给定大小
    let gradientLayer: CAGradientLayer = AppUtil.commonGradientLayer()

    fileprivate let normalColors: [CGColor] = [UIColor.init(hex: 0x169CFF).cgColor, UIColor.init(hex: 0x6EEEFC).cgColor]
    fileprivate let disableColors: [CGColor] = [UIColor.init(hex: 0x35426A).cgColor, UIColor.init(hex: 0x35426A).cgColor]
    fileprivate let highlightedColors: [CGColor] = [UIColor.init(hex: 0x169CFF).cgColor, UIColor.init(hex: 0x6EEEFC).cgColor]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
        //fatalError("init(coder:) has not been implemented")
    }

    fileprivate func commonInit() -> Void {
        self.layer.insertSublayer(self.gradientLayer, below: nil)
        self.gradientLayer.colors = self.normalColors
    }

    override var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled
            self.gradientLayer.colors = isEnabled ? self.normalColors : self.disableColors
        }
    }

    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = isHighlighted
            self.gradientLayer.colors = isHighlighted ? self.highlightedColors : self.normalColors
        }
    }

}
