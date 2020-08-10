//
//  GradientLayerButton.swift
//  BaseProject
//
//  Created by 小唐 on 2019/8/7.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  有一个渐变layer的UIButton
//  渐变layer的大小、显示 需自己手动处理，默认显示，且有默认渐变颜色

import UIKit

/// 有一个渐变layer的UIButton
class GradientLayerButton: UIButton {

    /// 渐变layer，需添加frame
    let gradientLayer = AppUtil.commonGradientLayer()

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
        //self.layer.addSublayer(self.gradientLayer)
        self.layer.insertSublayer(self.gradientLayer, below: nil)
    }

}
