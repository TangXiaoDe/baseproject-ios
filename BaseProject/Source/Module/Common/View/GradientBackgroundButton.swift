//
//  GradientBackgroundButton.swift
//  BaseProject
//
//  Created by 小唐 on 2019/3/6.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  渐变背景按钮
//  [注1] 正常状态下 背景色是渐变色；不可用状态下背景色0xbbbbbb；文字颜色为白色；
//  [注2] 使用xib加载时，容易设置各种状态的背景色，此时会导致默认commonInit中的设置无效；
//  [注3] 必须设置gradientState，即渐变状态，默认为normal
//  [注3] 不可对该按钮设置backgroundColor，否则展示效果无效；

import UIKit

/// 渐变背景按钮，注：需给渐变layer添加frame
class GradientBackgroundButton: UIButton {

    /// 渐变layer，需添加frame
    let gradientLayer = AppUtil.commonGradientLayer()

    var gradientState: UIControl.State = UIControl.State.normal {
        didSet {
            self.setupGradientState(gradientState)
        }
    }

    override var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled
            if self.gradientState == .normal {
                self.gradientLayer.isHidden = !isEnabled
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            if self.gradientState == .selected {
                self.gradientLayer.isHidden = !isSelected
            }
        }
    }
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = isHighlighted
            if self.gradientState == .highlighted {
                self.gradientLayer.isHidden = !isHighlighted
            }
        }
    }

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
        self.layer.addSublayer(gradientLayer)
        self.gradientState = .normal
    }

    fileprivate func setupGradientState(_ state: UIControl.State) -> Void {
        switch gradientState {
        case .normal:
            self.setBackgroundImage(UIImage.imageWithColor(UIColor.clear), for: .normal)
            self.setBackgroundImage(UIImage.imageWithColor(AppColor.disable), for: .disabled)
        case .selected:
            fallthrough
        case .highlighted:
            fallthrough
        default:
            self.setBackgroundImage(UIImage.imageWithColor(AppColor.disable), for: .normal)
            self.setBackgroundImage(UIImage.imageWithColor(AppColor.disable), for: .disabled)
            self.setBackgroundImage(UIImage.imageWithColor(UIColor.clear), for: state)
        }
    }

}
