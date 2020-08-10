//
//  UIView+SnapKit+Extension.swift
//  BaseProject
//
//  Created by 小唐 on 2019/6/15.
//  Copyright © 2019 ChainOne. All rights reserved.
//
//  UIView在SnapKit三方库下的扩展

import UIKit
import SnapKit

/// 线条位于视图的位置描述
public enum LineViewSide {
    // in 内侧
    case inBottom   // 内底(线条在view内的底部)
    case inTop      // 内顶
    case inLeft     // 内左
    case inRight    // 内右
    case inHorCenter // 水平方向居中
    case inVerCenter // 竖直方向居中
    // out 外侧
    case outBottom  // 外底(线条在view外的底部)
    case outTop     // 外顶
    case outLeft    // 外左
    case outRight   // 外右
}

public extension UIView {
    /**
     给视图添加线条
     - parameter side:      线条在视图的哪侧(内外 + 上下左右)
     - parameter color:     线条颜色
     - parameter thickness: 线条厚度(水平方向为高度，竖直方向为宽度)
     - parameter margin1:   水平方向表示左侧间距，竖直方向表示顶部间距
     - parameter margin2:             右侧间距            底部间距
     */
    @discardableResult
    func addLineWithSide(_ side: LineViewSide, color: UIColor, thickness: CGFloat, margin1: CGFloat, margin2: CGFloat) -> UIView {
        let lineView = UIView()
        self.addSubview(lineView)
        // 配置
        lineView.backgroundColor = color
        lineView.snp.makeConstraints { (make) in
            var horizontalFlag = true    // 线条方向标记
            switch side {
            // 线条为水平方向
            case .inBottom:
                make.bottom.equalTo(self)
                break
            case .inTop:
                make.top.equalTo(self)
                break
            case .outBottom:
                make.top.equalTo(self.snp.bottom)
                break
            case .outTop:
                make.bottom.equalTo(self.snp.bottom)
                break
            case .inHorCenter:
                make.centerY.equalTo(self)
                break
            // 线条方向为竖直方向
            case .inLeft:
                horizontalFlag = false
                make.left.equalTo(self)
                break
            case .inRight:
                horizontalFlag = false
                make.right.equalTo(self)
                break
            case .outLeft:
                horizontalFlag = false
                make.right.equalTo(self.snp.left)
                break
            case .outRight:
                horizontalFlag = false
                make.left.equalTo(self.snp.right)
                break
            case .inVerCenter:
                make.centerX.equalTo(self)
                break
            }
            // 约束
            if horizontalFlag   // 线条方向 为 水平方向
            {
                make.left.equalTo(self).offset(margin1)
                make.right.equalTo(self).offset(-margin2)
                make.height.equalTo(thickness)
            } else                // 线条方向 为 竖直方向
            {
                make.top.equalTo(self).offset(margin1)
                make.bottom.equalTo(self).offset(-margin2)
                make.width.equalTo(thickness)
            }
        }
        return lineView
    }
}
